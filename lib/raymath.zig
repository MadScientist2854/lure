pub const PI = 3.14159265358979323846;
pub const DEG2RAD = (PI/180.0);

pub const Vector2 = extern struct {
    x: f32,
    y: f32,

    // Vector with components value 0
    pub fn Zero() Vector2 {
        return Vector2 { .x = 0, .y = 0 };
    }
    // Vector with components value 1.0f
    pub fn One() Vector2 {
        return Vector2 { .x = 1, .y = 1 };
    }
    // Add two vectors (v1 + v2)
    pub fn Add(v1: Vector2, v2: Vector2) Vector2 {
        return Vector2 { .x = v1.x + v2.x, .y = v1.y + v2.y };
    }
    // Add vector and float value
    pub fn AddValue(v: Vector2, add: f32) Vector2 {
        return Vector2 { .x = v.x + add, .y = v.y + add };
    }
    // Subtract two vectors (v1 - v2)
    pub fn Subtract(v1: Vector2, v2: Vector2) Vector2 {
        return Vector2 { .x = v1.x - v2.x, .y = v1.y - v2.y };
    }
    // Subtract vector by float value
    pub fn SubtractValue(v: Vector2, sub: f32) Vector2 {
        return Vector2 { .x = v.x - sub, .y = v.y - sub };
    }
    // Calculate vector length
    pub fn Length(v: Vector2) f32 {
        return @sqrt((v.x*v.x) + (v.y*v.y));
    }
    // Calculate vector square length
    pub fn LengthSqr(v: Vector2) f32 {
        return (v.x*v.x) + (v.y*v.y);
    }
    // Calculate two vectors dot product
    pub fn DotProduct(v1: Vector2, v2: Vector2) f32 {
        return (v1.x*v2.x + v1.y*v2.y);
    }
    // Calculate distance between two vectors
    pub fn Distance(v1: Vector2, v2: Vector2) f32 {
        return @sqrt((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y));
    }
    // Calculate angle from two vectors in X-axis
    pub fn Angle(v1: Vector2, v2: Vector2) f32 {
        var result = @import("std").math.atan2(v2.y - v1.y, v2.x - v1.x)*(180/PI);
        if (result < 0) result += 360;
        return result;
    }
    // Scale vector (multiply by value)
    pub fn Scale(v: Vector2, scale: f32) Vector2 {
        return Vector2 { .x = v.x*scale, .y = v.y*scale };
    }
    // Multiply vector by vector
    pub fn Multiply(v1: Vector2, v2: Vector2) Vector2 {
        return Vector2 { .x = v1.x*v2.x, .y = v1.y*v2.y };
    }
    // Negate vector
    pub fn Negate(v: Vector2) Vector2 {
        return Vector2 { .x = -v.x, .y = -v.y };
    }
    // Divide vector by vector
    pub fn Divide(v1: Vector2, v2: Vector2) Vector2 {
        return Vector2 { .x = v1.x/v2.x, .y = v1.y/v2.y };
    }
    // Normalize provided vector
    pub fn Normalize(v: Vector2) Vector2 {
        const length = v.Length();
        if (length <= 0)
            return v;

        const result = v.Scale(1/length);
        return result;
    }
    // Calculate linear interpolation between two vectors
    pub fn Lerp(v1: Vector2, v2: Vector2, amount: f32) Vector2 {
        const result = Vector2{};

        result.x = v1.x + amount*(v2.x - v1.x);
        result.y = v1.y + amount*(v2.y - v1.y);

        return result;
    }
    // Calculate reflected vector to normal
    pub fn Reflect(v: Vector2, normal: Vector2) Vector2 {
        const result = Vector2{};

        const dotProduct = v.DotProduct(normal);

        result.x = v.x - (2*normal.x)*dotProduct;
        result.y = v.y - (2*normal.y)*dotProduct;

        return result;
    }
    // Rotate Vector by float in Degrees.
    pub fn Rotate(v: Vector2, degs: f32) Vector2 {
        const rads = degs*DEG2RAD;
        return Vector2 { .x = v.x*cosf(rads) - v.y*sinf(rads), .y = v.x*sinf(rads) + v.y*cosf(rads) };
    }
    // Move Vector towards target
    pub fn MoveTowards(v: Vector2, target: Vector2, maxDistance: f32) Vector2 {
        const result = Vector2{};
        const dx = target.x - v.x;
        const dy = target.y - v.y;
        const value = (dx*dx) + (dy*dy);

        if ((value == 0) or ((maxDistance >= 0) and (value <= maxDistance*maxDistance))) return target;

        const dist = @sqrt(value);

        result.x = v.x + dx/dist*maxDistance;
        result.y = v.y + dy/dist*maxDistance;

        return result;
    }
};