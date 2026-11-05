  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
require(Knit.Util.Trove);
local TweenService = game:GetService("TweenService");

local function CreateTween(u1, u2, p3) -- Line: 15
    -- upvalues: TweenService (copy)
    local u4 = p3 == nil and 0 or p3;
    local u5 = nil;
    coroutine.wrap(function() -- Line: 20
        -- upvalues: u4 (ref), u1 (copy), u2 (copy), TweenService (ref), u5 (ref)
        wait(u4);

        if type(u1) ~= "table" then
            u5 = TweenService:Create(u1, u2[1], u2[2]);
            u5:Play();

            return u5;
        end;

        local v6 = 1;
        local v7 = {};

        for _, v in pairs(u1) do
            local v8 = u2[v6];
            local v9 = v6 + 1;
            v6 = v9 + 1;
            v7[v.Name] = TweenService:Create(v, v8, u2[v9]);
            v7[v.Name]:Play();
        end;

        return v7;
    end)();
end;

return function(p10, p11, p12, p13, p14) -- Line: 46
    -- upvalues: Knit (copy), TweenService (copy)
    local v15 = {};
    local v16 = {};

    if p11:IsA("Attachment") then
        if p11:IsA("ParticleEmitter") then
            v15[1] = p11;
        end;
    else
        for _, child in pairs(p11:GetChildren()) do
            if child:IsA("Attachment") then
                table.insert(v15, child);
            elseif child:IsA("ParticleEmitter") then
                table.insert(v16, child);
            end;
        end;

        if #v15 <= 0 then
            return;
        end;
    end;

    local v17 = p13 or 1;

    for i = 1, #v15 do
        local v18 = v15[i]:Clone();
        v18.Parent = p10.HumanoidRootPart or p12;

        for _, descendant in pairs(v18:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                table.insert(v16, descendant);
            end;
        end;
    end;

    for _, v in pairs(v16) do
        v:Emit(v:GetAttribute("EmitCount"));

        if (Knit.CollectionService:HasTag(p10, "Timestopped") or workspace.Mechanics.TimeStopped:GetAttribute("User") == game.Players:GetPlayerFromCharacter(p10).Name) and p14 then
            local u19 = { v };
            local u20 = {
                TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                {
                    TimeScale = 0
                }
            };
            local v21 = nil;
            local u22 = v21 == nil and 0 or v21;
            local u23 = nil;
            coroutine.wrap(function() -- Line: 20
                -- upvalues: u22 (ref), u19 (copy), u20 (copy), TweenService (ref), u23 (ref)
                wait(u22);

                if type(u19) ~= "table" then
                    u23 = TweenService:Create(u19, u20[1], u20[2]);
                    u23:Play();

                    return u23;
                end;

                local v24 = 1;
                local v25 = {};

                for _, v2 in pairs(u19) do
                    local v26 = u20[v24];
                    local v27 = v24 + 1;
                    v24 = v27 + 1;
                    v25[v2.Name] = TweenService:Create(v2, v26, u20[v27]);
                    v25[v2.Name]:Play();
                end;

                return v25;
            end)();
        end;
    end;

    while Knit.CollectionService:HasTag(p10, "Timestopped") or workspace.Mechanics.TimeStopped:GetAttribute("User") == game.Players:GetPlayerFromCharacter(p10).Name do
        task.wait();
    end;

    for i = 1, #v16 do
        local u28 = { v16[i] };
        local u29 = {
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {
                TimeScale = 1
            }
        };
        local v30 = nil;
        local u31 = v30 == nil and 0 or v30;
        local u32 = nil;
        coroutine.wrap(function() -- Line: 20
            -- upvalues: u31 (ref), u28 (copy), u29 (copy), TweenService (ref), u32 (ref)
            wait(u31);

            if type(u28) ~= "table" then
                u32 = TweenService:Create(u28, u29[1], u29[2]);
                u32:Play();

                return u32;
            end;

            local v33 = 1;
            local v34 = {};

            for _, v in pairs(u28) do
                local v35 = u29[v33];
                local v36 = v33 + 1;
                v33 = v36 + 1;
                v34[v.Name] = TweenService:Create(v, v35, u29[v36]);
                v34[v.Name]:Play();
            end;

            return v34;
        end)();
        game.Debris:AddItem(v16[i], v17);
    end;
end;