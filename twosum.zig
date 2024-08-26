const std = @import("std");
pub fn main() !void {
    const case1 = [_]i32{ 2, 7, 11, 15 };
    const case2 = [_]i32{ 3, 2, 4 };
    const case3 = [_]i32{ 3, 3 };

    const allocator = std.heap.page_allocator;
    const result1 = twoSum(&case1, 9, allocator);
    const result2 = twoSum(&case2, 6, allocator);
    const result3 = twoSum(&case3, 6, allocator);
    std.debug.print("Result 1: {any}\n", .{result1});
    std.debug.print("Result 2: {any}\n", .{result2});
    std.debug.print("Result 3: {any}\n", .{result3});
}

pub fn twoSum(numbers: []const i32, target: i32, allocator: std.mem.Allocator) ![]i32 {
    var seenMap = std.AutoHashMap(i32, i32).init(allocator);
    defer seenMap.deinit();
    const hit = try allocator.alloc(i32, 2);
    for (0..numbers.len) |i| {
        const num = numbers[i];
        const integer: i32 = @intCast(i);
        if (seenMap.contains(num)) {
            hit[0] = integer;
            hit[1] = seenMap.get(num).?;
        } else {
            try seenMap.put(target - num, integer);
        }
    }
    return hit;
}
