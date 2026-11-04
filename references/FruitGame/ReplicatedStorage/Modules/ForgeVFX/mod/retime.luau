 

local u1 = require("./utility")
local u9 = {
    ["apply"] = function(p2, p3, p4) --[[ Name: apply, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p2:IsA("ParticleEmitter") then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "TimeScale_Duration")
            p2.Speed = NumberRange.new(p2.Speed.Min * p3, p2.Speed.Max * p3)
            p2.RotSpeed = NumberRange.new(p2.RotSpeed.Min * p3, p2.RotSpeed.Max * p3)
            p2.Lifetime = NumberRange.new(p2.Lifetime.Min / p3, p2.Lifetime.Max / p3)
            p2.Acceleration = p2.Acceleration * p3 ^ 2
            p2.Drag = p2.Drag * p3
            p2.Rate = p2.Rate * p3
            return
        elseif p2:IsA("Beam") then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "EffectDuration")
            u1.scaleAttribute(p2, p4, "Speed_Duration")
            u1.scaleAttribute(p2, p4, "Duration")
            p2.TextureSpeed = p2.TextureSpeed * p3
            return
        elseif p2:IsA("Trail") then
            p2.Lifetime = p2.Lifetime * p4
            return
        elseif p2:IsA("Sound") then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "EmitInterval")
            u1.scaleAttribute(p2, p4, "RepeatInterval")
            u1.scaleAttribute(p2, p4, "FadeOutTime")
            u1.scaleAttribute(p2, p4, "Volume_Duration")
            u1.scaleAttribute(p2, p4, "Speed_Duration")
            u1.scaleAttribute(p2, p4, "RollOff_Duration")
            return
        elseif p2:IsA("Model") then
            if u1.isMeshVFX(p2) then
                u1.scaleAttribute(p2, p4, "EmitDelay")
                u1.scaleAttribute(p2, p4, "DestroyDelay")
                u1.scaleAttribute(p2, p4, "EmitDuration")
                u1.scaleAttribute(p2, p4, "EffectDuration")
                u1.scaleAttribute(p2, p4, "Speed_Duration")
                u1.scaleAttribute(p2, p4, "Duration")
                u1.scaleAttribute(p2, p3, "Rate")
                u1.scaleAttribute(p2, p3, "Part_RotSpeed_Start")
                u1.scaleAttribute(p2, p3, "Part_RotSpeed_End")
            else
                u1.scaleAttribute(p2, p3, "SpinRotation")
                u1.scaleAttribute(p2, p4, "EmitDelay")
                u1.scaleAttribute(p2, p4, "ResetDelay")
                u1.scaleAttribute(p2, p4, "SpinDuration")
                u1.scaleAttribute(p2, p4, "Scale_Duration")
                u1.scaleAttribute(p2, p4, "SpinSpeed_Duration")
            end
        elseif p2:IsA("Attachment") and p2:HasTag(u1.BEZIER_TAG) then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "DestroyDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "Duration")
            u1.scaleAttribute(p2, p4, "Speed_Duration")
            u1.scaleAttribute(p2, p3, "ProjectileSpeed")
            u1.scaleAttribute(p2, p4, "ProjectileLifetime")
            u1.scaleAttribute(p2, p3, "Rate")
            u1.scaleAttribute(p2, p3, "Part_RotSpeed_Start")
            u1.scaleAttribute(p2, p3, "Part_RotSpeed_End")
            return
        elseif p2:IsA("Attachment") and p2:HasTag(u1.LIGHTNING_TAG) then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "DestroyDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "Duration")
            u1.scaleAttribute(p2, p4, "Speed_Duration")
            u1.scaleAttribute(p2, p4, "Color_Duration")
            u1.scaleAttribute(p2, p4, "Fill_Color_Duration")
            u1.scaleAttribute(p2, p4, "Fade_In_Duration")
            u1.scaleAttribute(p2, p4, "Fade_Out_Duration")
            u1.scaleAttribute(p2, p4, "Dissipate_Duration")
            u1.scaleAttribute(p2, p3, "ProjectileSpeed")
            u1.scaleAttribute(p2, p4, "ProjectileLifetime")
            u1.scaleAttribute(p2, p3, "Rate")
            u1.scaleAttribute(p2, p3, "RefreshRate")
            return
        elseif p2:IsA("BasePart") and (p2.Parent and u1.findFirstClassWithTag(p2.Parent, "Attachment", u1.SHOCKWAVE_TAG)) then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "Size_Duration")
            u1.scaleAttribute(p2, p4, "Transparency_Duration")
            u1.scaleAttribute(p2, p4, "Lifetime")
            u1.scaleAttribute(p2, p4, "Duration")
            u1.scaleAttribute(p2, p3, "Rate_Start")
            u1.scaleAttribute(p2, p3, "Rate_End")
            return
        elseif p2:IsA("RayValue") and p2:HasTag(u1.SCREENSHAKE_TAG) then
            u1.scaleAttribute(p2, p4, "EmitDelay")
            u1.scaleAttribute(p2, p4, "EmitDuration")
            u1.scaleAttribute(p2, p4, "Scale_Duration")
        elseif p2:IsA("RayValue") then
            u1.scaleAttribute(p2, p4, "Duration")
            u1.scaleAttribute(p2, p4, "Speed_Duration")
            u1.scaleAttribute(p2, p4, "EmitDelay")
        end
    end,
    ["batch"] = function(p5, ...) --[[ Name: batch, Line 112 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        local v6 = 1 / p5
        for _, v7 in { ... } do
            u9.apply(v7, p5, v6)
            for _, v8 in v7:GetDescendants() do
                u9.apply(v8, p5, v6)
            end
        end
    end
}
return u9