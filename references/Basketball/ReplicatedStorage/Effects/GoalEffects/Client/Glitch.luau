 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 23
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local function Destroy_Effect(u4: userdata, p5: number) -- Line: 33
    task.delay(p5, function() -- Line: 34
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

return function(p6, p7) -- Line: 39
    -- upvalues: VfxManager (copy), Players (copy)
    local _ = p7.ScoreTeam;
    local v8 = script.GlitchFX:Clone();
    v8.Parent = workspace.Debris;
    v8:PivotTo(p7.CFrame);
    VfxManager.Emit(v8);
    task.delay(3, v8.Destroy, v8);
    local AuraBodyPartsToWeld = script.Glitch_Aura.AuraBodyPartsToWeld;

    for _, v in Players:GetPlayers() do
        if v.Character ~= nil and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p7.ScoreTeam and v.Team ~= game.Teams.Visitor)) then
            local Character = v.Character;
            local _ = v.Character.HumanoidRootPart;
            local u9 = {};

            for _, child in AuraBodyPartsToWeld:GetChildren() do
                local v10 = Character:FindFirstChild(child.Name);

                if v10 then
                    for _, child2 in child:GetChildren() do
                        local v11 = child2:Clone();
                        v11.Parent = v10;
                        v11.Enabled = true;
                        table.insert(u9, v11);
                    end;
                end;
            end;

            task.delay(1, function() -- Line: 73
                -- upvalues: u9 (copy)
                for _, v2 in u9 do
                    if v2:IsA("ParticleEmitter") then
                        v2.Enabled = false;
                        task.delay(2, function() -- Line: 77
                            -- upvalues: v2 (copy)
                            v2:Destroy();
                        end);
                    end;
                end;

                task.wait(1);
                table.clear(u9);
            end);
        end;
    end;
end;