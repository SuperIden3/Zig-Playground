const std = @import("std");

pub fn read_file(filename: []const u8) ![]const u8 {
    var file = try std.fs.cwd().openFile(filename, .{}); // open the file
    defer file.close(); // close the file later

    const contents = try file.reader().readAllAlloc(std.heap.page_allocator, std.math.maxInt(usize)); // read the file
    defer std.heap.page_allocator.free(contents); // free the memory later

    return contents; // return the contents
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "read_file function test" {
    const contents = try read_file("src/main.zig");
    try std.testing.expect(contents.len > 0);
    std.debug.print("Contents read\n", .{});
}

