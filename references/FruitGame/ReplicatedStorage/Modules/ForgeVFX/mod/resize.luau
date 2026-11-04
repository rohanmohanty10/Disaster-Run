 

local u1 = require("./utility")
local u15 = {
    ["apply"] = function(p2, p3) --[[ Name: apply, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p2:IsA("ParticleEmitter") then
            p2.Size = u1.scaleNumberSequence(p2.Size, p3)
            p2.Speed = NumberRange.new(p2.Speed.Min * p3, p2.Speed.Max * p3)
            p2.Acceleration = p2.Acceleration * p3
            return
        elseif p2:IsA("Beam") then
            u1.scaleAttribute(p2, p3, "Width0_Start")
            u1.scaleAttribute(p2, p3, "Width1_Start")
            u1.scaleAttribute(p2, p3, "Width0_End")
            u1.scaleAttribute(p2, p3, "Width1_End")
            u1.scaleAttribute(p2, p3, "CurveSize0_Start")
            u1.scaleAttribute(p2, p3, "CurveSize1_Start")
            u1.scaleAttribute(p2, p3, "CurveSize0_End")
            u1.scaleAttribute(p2, p3, "CurveSize1_End")
            u1.scaleAttribute(p2, p3, "Length_Scale_Start")
            u1.scaleAttribute(p2, p3, "Length_Scale_End")
            p2.Width0 = p2.Width0 * p3
            p2.Width1 = p2.Width1 * p3
            p2.CurveSize0 = p2.CurveSize0 * p3
            p2.CurveSize1 = p2.CurveSize1 * p3
            local v4 = p2.Attachment0
            local v5 = p2.Attachment1
            u1.scaleAttachmentDistance(v4, v5, p3)
            return
        elseif p2:IsA("Trail") then
            local v6 = p2.Attachment0
            local v7 = p2.Attachment1
            u1.scaleAttachmentDistance(v6, v7, p3)
            return
        elseif p2:IsA("Sound") then
            p2.RollOffMinDistance = p2.RollOffMinDistance * p3
            p2.RollOffMaxDistance = p2.RollOffMaxDistance * p3
            u1.scaleAttribute(p2, p3, "RollOff_Start")
            u1.scaleAttribute(p2, p3, "RollOff_End")
        elseif p2:IsA("Model") then
            if not u1.isMeshVFX(p2) then
                u1.scaleAttribute(p2, p3, "Scale_Start")
                u1.scaleAttribute(p2, p3, "Scale_End")
                return
            end
            local v8 = p2:FindFirstChild("Start")
            local v9 = p2:FindFirstChild("End")
            if v8 and v9 then
                v8.Size = v8.Size * p3
                v9.Size = v9.Size * p3
                local v10 = v8:FindFirstChildOfClass("SpecialMesh")
                local v11 = v9:FindFirstChildOfClass("SpecialMesh")
                if v10 and v11 then
                    v10.Scale = v10.Scale * p3
                    v11.Scale = v11.Scale * p3
                    return
                end
            end
        else
            if p2:IsA("Attachment") and p2:HasTag(u1.LIGHTNING_TAG) then
                u1.scaleAttribute(p2, p3, "OffsetScale")
                u1.scaleAttribute(p2, p3, "Width_Start")
                u1.scaleAttribute(p2, p3, "Width_End")
                return
            end
            if p2:IsA("BasePart") and (p2.Parent and u1.findFirstClassWithTag(p2.Parent, "Attachment", u1.SHOCKWAVE_TAG)) then
                u1.scaleAttribute(p2, p3, "Radius")
                u1.scaleAttribute(p2, p3, "Length")
                u1.scaleAttribute(p2, p3, "MinSize")
                u1.scaleAttribute(p2, p3, "MaxSize")
                if p2:GetAttribute("LinearMagnitude") then
                    p2.Size = p2.Size * p3
                    u1.scaleAttribute(p2, p3, "LinearMagnitude")
                    u1.scaleAttribute(p2, p3, "AngularMagnitude")
                    return
                end
            elseif p2:IsA("RayValue") and p2:HasTag(u1.SCREENSHAKE_TAG) then
                u1.scaleAttribute(p2, p3, "Falloff")
            end
        end
    end,
    ["batch"] = function(p12, ...) --[[ Name: batch, Line 85 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        for _, v13 in { ... } do
            u15.apply(v13, p12)
            for _, v14 in v13:GetDescendants() do
                u15.apply(v14, p12)
            end
        end
    end
}
return u15