 

local u1 = require(script.Parent.Switch)
local _ = math.abs
function getNormalFromPartFace(p2, p3)
    return p2.CFrame:VectorToWorldSpace(Vector3.FromNormalId(p3))
end
function normalVectorToFace(p4, p5)
    local v6 = {
        Enum.NormalId.Front,
        Enum.NormalId.Back,
        Enum.NormalId.Bottom,
        Enum.NormalId.Top,
        Enum.NormalId.Left,
        Enum.NormalId.Right
    }
    for _, v7 in ipairs(v6) do
        if getNormalFromPartFace(p4, v7):Dot(p5) > 0.999 then
            return v7
        end
    end
    return nil
end
function getTopLeftCorners(p8)
    local v9 = p8.Size
    return {
        [Enum.NormalId.Front] = p8.CFrame * CFrame.new(v9.X / 2, v9.Y / 2, -v9.Z / 2),
        [Enum.NormalId.Back] = p8.CFrame * CFrame.new(-v9.X / 2, v9.Y / 2, v9.Z / 2),
        [Enum.NormalId.Right] = p8.CFrame * CFrame.new(v9.X / 2, v9.Y / 2, v9.Z / 2),
        [Enum.NormalId.Left] = p8.CFrame * CFrame.new(-v9.X / 2, v9.Y / 2, -v9.Z / 2),
        [Enum.NormalId.Bottom] = p8.CFrame * CFrame.new(v9.X / 2, -v9.Y / 2, v9.Z / 2),
        [Enum.NormalId.Top] = p8.CFrame * CFrame.new(-v9.X / 2, v9.Y / 2, v9.Z / 2)
    }
end
function getRotationComponents(p10)
    local v11 = { p10:GetComponents() }
    table.remove(v11, 1)
    table.remove(v11, 2)
    table.remove(v11, 3)
    return v11
end
function mapOffsetToFace(p12, p13, p14)
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v15 = getRotationComponents(p12)
    local v16 = u1(p13)
    local v17 = {
        ["X"] = u1(p14)({
            [{
                Enum.NormalId.Right,
                Enum.NormalId.Left,
                Enum.NormalId.Top,
                Enum.NormalId.Bottom
            }] = CFrame.new(p12.Z, p12.Y, p12.X, unpack(v15)),
            [{ Enum.NormalId.Front, Enum.NormalId.Back }] = p12
        }),
        ["Y"] = u1(p14)({
            [{ Enum.NormalId.Right, Enum.NormalId.Left }] = CFrame.new(p12.Z, p12.Y, p12.X, unpack(v15)),
            [{ Enum.NormalId.Front, Enum.NormalId.Back }] = p12,
            [{ Enum.NormalId.Top, Enum.NormalId.Bottom }] = CFrame.new(p12.Y, p12.X, p12.Z, unpack(v15))
        })
    }
    return v16(v17)
end
return {
    ["normalVectorToFace"] = normalVectorToFace,
    ["getTopLeftCorners"] = getTopLeftCorners,
    ["mapOffsetToFace"] = mapOffsetToFace
}