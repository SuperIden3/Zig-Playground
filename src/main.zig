const std = @import("std");

// stdout
const stdout_file = std.io.getStdOut().writer();
var stdout_writer = std.io.bufferedWriter(stdout_file);
const stdout = stdout_writer.writer();

// stderr
const stderr_file = std.io.getStdErr().writer();
var stderr_writer = std.io.bufferedWriter(stderr_file);
const stderr = stderr_writer.writer();

// stdin
const stdin = std.io.getStdIn().reader();

// allocator
const allocator = std.heap.page_allocator;

// constants
const max_int = std.math.maxInt(usize);
const pwd = std.fs.cwd();

pub fn ask(question: []const u8) ?[]u8 {
    stderr.print("{s}", .{question}) catch unreachable;
    stderr_writer.flush() catch unreachable;

    const answer: ?[]u8 = stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize)) catch unreachable;
    return answer;
} // Cannot test because of `zig build test` output interference

pub fn main() !void {
    const args = try std.process.argsAlloc(allocator);
    defer allocator.free(args);

    const name = ask("What is your name? ").?;
    defer allocator.free(name);
    stdout.print("Hello, {s}!\n", .{name}) catch unreachable;
    stdout_writer.flush() catch unreachable;
}
