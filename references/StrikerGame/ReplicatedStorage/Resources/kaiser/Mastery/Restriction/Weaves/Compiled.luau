 
 

local TweenService = game:GetService("TweenService");

local function midSequence(p1) -- Line: 3
    return NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, p1), NumberSequenceKeypoint.new(1, 1) });
end;

local function fadeOutSequence(p2) -- Line: 11
    return NumberSequence.new({ NumberSequenceKeypoint.new(0, p2), NumberSequenceKeypoint.new(1, 1) });
end;

return {
    { 0, function(p3) -- Line: 20
            shared.vfx.emit(p3["left arm trail"], p3["left leg"], p3["right arm trail"], p3["left leg"], p3["for restriction weaves"]);
        end },
    { 10, function(p4) -- Line: 31
            shared.vfx.emit(p4["impact 2"]);
        end },
    { 30, function(p5) -- Line: 36
            shared.vfx.emit(p5["impact 1"]);
        end },
    { 50, function(p6) -- Line: 41
            shared.vfx.emit(p6.impact);
        end },
    { 74, function(p7) -- Line: 46
            shared.vfx.emit(p7["run effect"]);
            shared.vfx.emit(p7["start up"]);
        end },
    { 76, function(p8) -- Line: 52
            -- upvalues: TweenService (copy), midSequence (copy), fadeOutSequence (copy)
            local chigirinsdsvfx2 = p8.chigirinsdsvfx2;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = chigirinsdsvfx2;
            NumberValue.Value = 1;
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();

            for _, descendant in pairs(chigirinsdsvfx2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Transparency = midSequence(1);
                    descendant.TextureSpeed = 10;
                    TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TextureSpeed = 0.01
                    }):Play();
                    local u9 = false;
                    local u10 = NumberValue.Changed:Connect(function() -- Line: 71
                        -- upvalues: u9 (ref), descendant (copy), fadeOutSequence (ref), NumberValue (copy), midSequence (ref)
                        if u9 then
                            descendant.Transparency = fadeOutSequence(NumberValue.Value);

                            return;
                        end;

                        descendant.Transparency = midSequence(NumberValue.Value);
                    end);
                    task.delay(0.3, function() -- Line: 79
                        -- upvalues: u9 (ref), descendant (copy), u10 (ref)
                        u9 = true;
                        task.wait(1);
                        descendant.Enabled = false;
                        u10:Disconnect();
                    end);
                end;
            end;

            task.delay(0.3, function() -- Line: 88
                -- upvalues: TweenService (ref), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
                task.wait(1);
                NumberValue:Destroy();
            end);
        end }
};