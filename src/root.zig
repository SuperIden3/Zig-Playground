const _main = @import("./main.zig");
//const std = @import("std");
pub fn main() void {
    //std.debug.print("Running...\n", .{});
    _main.main() catch unreachable;
    //std.debug.print("Done.\n", .{});
}
