 

 

local TweenService = game:GetService("TweenService");
local u1 = { "ParticleEmitter", "Beam", "Trail", "PointLight", "SpotLight" };

local function Enable(p2: any, p3: boolean) -- Line: 7
    -- upvalues: u1 (copy), Enable (copy)
    local v4;

    if typeof(p2) == "Instance" then
        v4 = p2:GetDescendants();
    else
        v4 = p2;
    end;

    local v5 = p3 or false;

    if typeof(p2) == "Instance" and table.find(u1, p2.ClassName) then
        p2.Enabled = v5;
    end;

    for _, v in v4 do
        if typeof(v) == "table" then
            Enable(v, v5);
        elseif table.find(u1, v.ClassName) then
            v.Enabled = v5;
        end;
    end;
end;

local function Emit(p6) -- Line: 28
    -- upvalues: Emit (copy), Enable (copy)
    if typeof(p6) == "Instance" then
        p6 = p6:GetDescendants();
    end;

    for _, v in p6 do
        if typeof(v) == "table" then
            Emit(v);
        elseif table.find({ "ParticleEmitter" }, v.ClassName) then
            task.spawn(function() -- Line: 40
                -- upvalues: v (copy), Enable (ref)
                if v:GetAttribute("EmitDelay") then
                    task.wait(v:GetAttribute("EmitDelay"));
                end;

                v:Emit(v:GetAttribute("EmitCount") or (v:GetAttribute("Rate") or v.Rate));

                if v:GetAttribute("EmitDuration") then
                    Enable(v, true);
                    task.wait(v:GetAttribute("EmitDuration"));
                    Enable(v, false);
                end;
            end);
        end;
    end;
end;

return {
    emitAndFreeze = function(u7: userdata, u8: number, u9: number) -- Line: 60, Name: emitAndFreeze
        -- upvalues: Emit (copy), TweenService (copy)
        Emit(u7);
        task.spawn(function() -- Line: 63
            -- upvalues: u7 (copy), TweenService (ref), u9 (copy), u8 (copy)
            for _, descendant in u7:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    TweenService:Create(descendant, TweenInfo.new(u9, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TimeScale = 0.05
                    }):Play();
                end;
            end;

            task.wait(u9 + u8);

            for _, descendant in u7:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    TweenService:Create(descendant, TweenInfo.new(u9, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TimeScale = 1
                    }):Play();
                end;
            end;
        end);
    end
};