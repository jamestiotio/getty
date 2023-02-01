const std = @import("std");

const t = @import("../testing.zig");

/// Specifies all types that can be serialized by this block.
pub fn is(
    /// The type of a value being serialized.
    comptime T: type,
) bool {
    return comptime std.meta.trait.isZigString(T);
}

/// Specifies the serialization process for values relevant to this block.
pub fn serialize(
    /// An optional memory allocator.
    allocator: ?std.mem.Allocator,
    /// A value being serialized.
    value: anytype,
    /// A `getty.Serializer` interface value.
    serializer: anytype,
) @TypeOf(serializer).Error!@TypeOf(serializer).Ok {
    _ = allocator;

    return try serializer.serializeString(value);
}

test "serialize - string" {
    try t.run(serialize, "abc", &.{.{ .String = "abc" }});
    try t.run(serialize, &[_]u8{ 'a', 'b', 'c' }, &.{.{ .String = "abc" }});
    try t.run(serialize, &[_:0]u8{ 'a', 'b', 'c' }, &.{.{ .String = "abc" }});
}
