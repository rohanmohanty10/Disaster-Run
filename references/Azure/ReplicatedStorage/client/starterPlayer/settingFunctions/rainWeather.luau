 

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
local Lighting = game:GetService("Lighting");
local workspace_CurrentCamera = workspace.CurrentCamera;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
local _ = ReplicatedStorage.client.starterPlayer;
require(ReplicatedStorage.packets);

return function(u1) -- Line: 28
    -- upvalues: ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), Lighting (copy), RunService (copy), workspace_CurrentCamera (copy)
    local function destroy() -- Line: 44
        -- upvalues: u1 (copy)
        for _, v in u1.rainTable do
            v:Destroy();
        end;

        u1.rainTable = nil;
    end;

    if u1.rainTable then
        for _, v in u1.rainTable do
            v:Destroy();
        end;

        u1.rainTable = nil;

        return;
    end;

    u1.rainTable = {};

    for _, child in ipairs(ReplicatedStorage.Resources.weather.rain:GetChildren()) do
        if not child:IsA("Part") then
            if child:IsA("Sound") then
                table.insert(u1.rainTable, soundUtil:play(ReplicatedStorage.Resources.weather.rain.atmosphereSoundEffect, SoundService));
            else
                local v2 = child:Clone();
                v2.Name = `RAIN - {v2.Name}`;
                v2.Parent = v2:IsA("Model") and workspace.Terrain or Lighting;

                if v2:IsA("Model") then
                    for _, descendant in ipairs(v2:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                            descendant.Enabled = true;
                        end;
                    end;
                end;

                table.insert(u1.rainTable, v2);
            end;
        end;
    end;

    local u3 = ReplicatedStorage.Resources.weather.rain["RAIN ( cam )"]:Clone();
    u3.Parent = workspace.Terrain;
    local u4 = nil;
    u4 = RunService.PreRender:connect(function() -- Line: 86
        -- upvalues: u3 (copy), u4 (ref), workspace_CurrentCamera (ref)
        if not u3:IsDescendantOf(game) then
            u4:Disconnect();
        end;

        u3.Position = workspace_CurrentCamera.CFrame.Position;
    end);
    table.insert(u1.rainTable, u3);
end;