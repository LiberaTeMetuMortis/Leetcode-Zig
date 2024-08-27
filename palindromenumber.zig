const std = @import("std");

pub fn main() !void {
    const result1 = try isPalindrome(121);
    const result2 = try isPalindrome(-121);
    const result3 = try isPalindrome(10);
    std.debug.print("Result 1: {any}\n", .{result1});
    std.debug.print("Result 2: {any}\n", .{result2});
    std.debug.print("Result 3: {any}\n", .{result3});
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

// TODO: Solve with fully mathemathical approach
