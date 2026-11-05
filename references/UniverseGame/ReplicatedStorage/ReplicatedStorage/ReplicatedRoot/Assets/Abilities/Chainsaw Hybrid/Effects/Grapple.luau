  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local TweenService = game:GetService("TweenService");
local FXService = require(ReplicatedRoot.Services.FXService);
local AbilityService = require(ReplicatedRoot.Services.Gameplay.AbilityService);
local Types = FXService.Types;
require(ReplicatedRoot.Services.CombatService);
local RunService = game:GetService("RunService");

return FXService.DefineEffect({
    Type = "Reliable",
    Identifier = script:GetFullName(),
    Reference = script.Reference,
    Definition = Types.Struct({}),

    Run = function(p1) -- Line: 24, Name: Run
        -- upvalues: Trove (copy), AbilityService (copy), Core (copy), TweenService (copy), RunService (copy)
        local Reference = p1.Reference;
        local Collector = p1.Collector;
        local u2 = Trove.new();
        local u3 = true;
        local Directory = AbilityService.GetAbilityData({
            Ability = "Chainsaw Hybrid"
        }).Directory;
        local u4 = u2:Construct(Instance, "Attachment");
        local u5 = u2:Construct(Instance, "Attachment");
        local u6 = u2:Construct(Instance, "Attachment");
        u6.Name = "TravelAttachment";
        u6.Parent = workspace.Terrain;
        local u7 = u2:Clone(Core.Get({
            Path = "~/Particles/Devil_Chain/Beam"
        }, Directory));
        u7.Attachment0 = u4;
        u7.Enabled = false;
        u7.Parent = u4;
        local u8 = nil;
        local u9 = nil;
        local u10 = "Disconnected";
        local u11 = "Disconnected";

        local function SetAttachment(p12, ...) -- Line: 58
            local v13 = { ... };
            local v14, v15;

            if #v13 > 1 then
                v14, v15 = ...;
            else
                if #v13 ~= 1 then
                    p12.Parent = nil;

                    return;
                end;

                if typeof(...) == "Instance" then
                    v14 = ...;
                    v15 = Vector3.new(0, 0, 0);
                else
                    v14 = game.Workspace.Terrain;
                    v15 = ...;
                end;
            end;

            p12.Parent = v14;
            p12.Position = v15;
        end;

        local function Travel(p16, p17, p18) -- Line: 80
            -- upvalues: TweenService (ref), u8 (ref), u9 (ref)
            local v19, v20 = TweenService:SmoothDamp(u8, p16, u9, 0.01, p17, p18);

            return v19, v20, (v19 - p16).Magnitude;
        end;

        local function Update(p21) -- Line: 85
            -- upvalues: u3 (ref), u11 (ref), Reference (copy), u4 (copy), u5 (copy), u10 (ref), u7 (copy), u6 (copy), u8 (ref), u9 (ref), TweenService (ref), u2 (copy)
            if u3 then
                u11 = Reference.State.Value;
                local Value = Reference.StartPart.Value;

                if Value ~= nil and u4.Parent ~= Value then
                    u4.Parent = Value;
                end;

                u4.Position = Reference.StartPosition.Value;
                local Value2 = Reference.EndPart.Value;

                if Value2 ~= nil and u5.Parent ~= Value2 then
                    u5.Parent = Value2;
                end;

                u5.Position = Reference.EndPosition.Value;
            else
                u11 = "Disconnected";
            end;

            if u10 ~= u11 then
                if u10 == "Disconnected" then
                    u10 = "Traveling";
                    u7.Attachment1 = u6;
                    u7.Enabled = true;
                    u8 = u4.WorldPosition;
                    u9 = Vector3.new(0, 0, 0);
                elseif u10 == "Connected" then
                    u10 = "Traveling";
                    u7.Attachment1 = u6;
                    u7.Enabled = true;
                    u8 = u5.WorldPosition;
                    u9 = Vector3.new(0, 0, 0);
                end;
            end;

            if u10 == "Traveling" then
                local v22 = nil;

                if u3 then
                    if u11 == "Traveling" then
                        v22 = Reference.TravelPosition.Value;
                    elseif u11 == "Disconnected" then
                        v22 = u4.WorldPosition;
                    elseif u11 == "Connected" then
                        v22 = u5.WorldPosition;
                    end;
                else
                    v22 = u4.WorldPosition;
                end;

                local v23, v24 = TweenService:SmoothDamp(u8, v22, u9, 0.01, 200, p21);
                local Magnitude = (v23 - v22).Magnitude;
                local _ = (u8 - v22).Magnitude;
                u6.Position = v23;
                u8 = v23;
                u9 = v24;

                if Magnitude <= 0.25 and u11 ~= "Traveling" then
                    u10 = u11;

                    if u10 == "Connected" then
                        u7.Attachment1 = u5;
                        u7.Enabled = true;
                    else
                        u7.Attachment1 = nil;
                        u7.Enabled = false;
                    end;

                    u9 = Vector3.new(0, 0, 0);
                end;
            end;

            if u10 == u11 and (u11 == "Disconnected" and not u3) then
                u2:Destroy();
            end;
        end;

        Collector:Add(function() -- Line: 189
            -- upvalues: u3 (ref)
            u3 = false;
        end);
        u2:Connect(RunService.PreRender, Update);
    end
});