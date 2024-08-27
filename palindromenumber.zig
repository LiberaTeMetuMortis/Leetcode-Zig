const std = @import("std");
const math = std.math;

pub fn main() !void {
    const result1 = try isPalindrome(121);
    const result2 = try isPalindrome(-121);
    const result3 = try isPalindrome(10);
    std.debug.print("Result 1: {any}\n", .{result1});
    std.debug.print("Result 2: {any}\n", .{result2});
    std.debug.print("Result 3: {any}\n", .{result3});
    const allocator = std.heap.page_allocator;
    const result4 = try isPalindromeMathemathical(121, allocator);
    const result5 = try isPalindromeMathemathical(-121, allocator);
    const result6 = try isPalindromeMathemathical(10, allocator);
    std.debug.print("Result 4: {any}\n", .{result4});
    std.debug.print("Result 5: {any}\n", .{result5});
    std.debug.print("Result 6: {any}\n", .{result6});
}

pub fn isPalindrome(number: i32) !bool {
    // Stringifying the number
    const abs = if (number < 0) number * -1 else number;
    var emptyBuffer: [256]u8 = undefined;
    const written = try std.fmt.bufPrint(&emptyBuffer, "{}", .{abs});
    for (0..written.len) |i| {
        if (written[i] != written[written.len - i - 1]) return false;
        if (i > written.len - i - 1) break;
    }
    return true;
}

// Solved with fully mathemathical approach
pub fn calcLength(number: f32) usize {
    var result: usize = @intFromFloat(std.math.ceil(math.log10(number)));
    if (@rem(number, 10) == 0) result += 1;
    return result;
}

pub fn isPalindromeMathemathical(number: i32, allocator: std.mem.Allocator) !bool {
    const abs: f32 = @floatFromInt(if (number < 0) number * -1 else number);
    const length: usize = calcLength(abs);
    var numberArr = try allocator.alloc(f32, length);
    var curr = abs;
    const halfLength = length / 2;
    for (0..length) |i| {
        const power: f32 = @floatFromInt(length - i - 1);
        const place = math.pow(f32, 10, power);
        const division = curr / place;
        const divisionWithoutRemainder = math.floor(division);
        curr -= divisionWithoutRemainder * place;
        numberArr[i] = divisionWithoutRemainder;
        if (i + 1 > halfLength) {
            if (numberArr[length - i - 1] != divisionWithoutRemainder) return false;
        }
    }

    return true;
}
