  

 

local v1 = {};
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Utility.CommonUtil);
require(ReplicatedRoot.Services.TagService);
require(ReplicatedRoot.Services.StateService);
require(ReplicatedRoot.Services.SequenceService);
require(ReplicatedRoot.Services.Gameplay.WorldService);
local FXService = require(ReplicatedRoot.Services.FXService);
local RunService = game:GetService("RunService");
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

function v1.Init(p2) -- Line: 23
    -- upvalues: Core (copy), Trove (copy), FXService (copy), RunService (copy)
    local u3 = Core.Require({
        Path = "Effects/Combat/Hover"
    });

    function p2.CreateHover(p4) -- Line: 28
        -- upvalues: Trove (ref), u3 (copy), FXService (ref), Core (ref), RunService (ref)
        local Character = p4.Character;
        local Object = p4.Object;

        if not Object then
            if Character then
                Object = Character:FindFirstChild("HumanoidRootPart") or nil;
            else
                Object = nil;
            end;
        end;

        local Player = p4.Player;

        if not Player then
            if Character then
                Player = game.Players:GetPlayerFromCharacter(Character) or nil;
            else
                Player = nil;
            end;
        end;

        local Reference = p4.Reference;
        local CurrentCamera = workspace.CurrentCamera;
        local u5 = Trove.new();

        if not Reference then
            Reference = u5:Clone(u3.Reference);
            Reference.Parent = FXService.References;
        end;

        local v6;

        if Reference then
            v6 = Reference.Attachment.Value;
        else
            v6 = nil;
        end;

        if not v6 then
            v6 = u5:Construct(Instance, "Attachment");
            v6.Parent = Object;
            Reference.Attachment.Value = v6;
        end;

        local u7;

        if Reference then
            u7 = Reference.TargetAttachment.Value;
        else
            u7 = nil;
        end;

        if not u7 then
            u7 = u5:Construct(Instance, "Attachment");
            u7.Visible = false;
            u7.Parent = workspace.Terrain;
            Reference.TargetAttachment.Value = u7;
        end;

        local u8;

        if Reference then
            u8 = Reference.AlignPosition.Value;
        else
            u8 = nil;
        end;

        if not u8 then
            u8 = u5:Construct(Instance, "AlignPosition");
            u8.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            u8.MaxAxesForce = Vector3.new(40000, 40000, 40000);
            u8.MaxVelocity = 48;
            u8.Responsiveness = 24;
            u8.Attachment0 = v6;
            u8.Attachment1 = u7;
            u8.Parent = Object;
            Reference.AlignPosition.Value = u8;
        end;

        local u9;

        if Reference then
            u9 = Reference.AlignOrientation.Value;
        else
            u9 = nil;
        end;

        if not u9 then
            u9 = u5:Construct(Instance, "AlignOrientation");
            u9.MaxTorque = 80000;
            u9.MaxAngularVelocity = 8;
            u9.Responsiveness = 64;
            u9.Attachment0 = v6;
            u9.Attachment1 = u7;
            u9.Parent = Object;
            Reference.AlignOrientation.Value = u8;
        end;

        local u10 = {
            Connection = nil,
            Collector = u5,
            Attachment = v6,
            TargetAttachment = u7,
            AlignPosition = u8,
            AlignOrientation = u9,
            Reference = Reference
        };

        local function UpdateCFrame() -- Line: 96
            -- upvalues: u10 (copy)
            local v11 = u10.Reference:GetAttribute("Position");
            local v12 = u10.Reference:GetAttribute("Orientation");
            u10.Reference:SetAttribute("CFrame", CFrame.new(v11) * CFrame.Angles(math.rad(v12.X), math.rad(v12.Y), (math.rad(v12.Z))));
        end;

        local function UpdateMover() -- Line: 102
            -- upvalues: u7 (ref), u10 (copy)
            u7.CFrame = u10.Reference:GetAttribute("CFrame");
        end;

        function u10.SetPosition(p13, p14) -- Line: 106
            -- upvalues: u10 (copy), UpdateCFrame (copy), u7 (ref)
            u10.Reference:SetAttribute("Position", p14);
            UpdateCFrame();
            u7.CFrame = u10.Reference:GetAttribute("CFrame");
        end;

        function u10.SetOrientation(p15, p16) -- Line: 112
            -- upvalues: u10 (copy), UpdateCFrame (copy), u7 (ref)
            u10.Reference:SetAttribute("Orientation", p16);
            UpdateCFrame();
            u7.CFrame = u10.Reference:GetAttribute("CFrame");
        end;

        function u10.SetDirection(p17, p18) -- Line: 118
            -- upvalues: u10 (copy), UpdateCFrame (copy), u7 (ref)
            local v19, v20, v21 = CFrame.lookAt(Vector3.new(0, 0, 0), p18):ToEulerAnglesXYZ();
            local Reference2 = u10.Reference;
            local v22 = math.deg(v19);
            local v23 = math.deg(v20);
            local v24 = math.deg(v21);
            Reference2:SetAttribute("Orientation", (Vector3.new(v22, v23, v24)));
            UpdateCFrame();
            u7.CFrame = u10.Reference:GetAttribute("CFrame");
        end;

        function u10.SetCFrame(p25, p26) -- Line: 125
            -- upvalues: u10 (copy), u7 (ref)
            local v27, v28, v29 = p26:ToOrientation();
            u10.Reference:SetAttribute("Position", p26.Position);
            local Reference2 = u10.Reference;
            local v30 = math.deg(v27);
            local v31 = math.deg(v28);
            local v32 = math.deg(v29);
            Reference2:SetAttribute("Orientation", (Vector3.new(v30, v31, v32)));
            u10.Reference:SetAttribute("CFrame", p26);
            u7.CFrame = u10.Reference:GetAttribute("CFrame");
        end;

        function u10.SetRotationMode(p33, p34) -- Line: 133
            -- upvalues: u10 (copy)
            u10.Reference:SetAttribute("RotationMode", p34);
        end;

        function u10.Update(p35, p36) -- Line: 137
            -- upvalues: u10 (copy), u8 (ref), u9 (ref), Core (ref), CurrentCamera (copy)
            if u10.Reference:GetAttribute("Enabled") then
                u8.Enabled = true;
            else
                u8.Enabled = false;
            end;

            if u10.Reference:GetAttribute("Enabled") and u10.Reference:GetAttribute("RotationMode") ~= "Disabled" then
                u9.Enabled = true;

                if Core.Context == "Client" then
                    if u10.Reference:GetAttribute("RotationMode") == "CameraY" then
                        local Position = CurrentCamera.CFrame.Position;
                        u10:SetDirection(CFrame.lookAt(Position * Vector3.new(1, 0, 1), (Position + CurrentCamera.CFrame.LookVector) * Vector3.new(1, 0, 1)).LookVector);

                        return;
                    end;

                    if u10.Reference:GetAttribute("RotationMode") == "CameraXYZ" then
                        u10:SetDirection(CurrentCamera.CFrame.LookVector);
                    end;
                end;
            else
                u9.Enabled = false;
            end;
        end;

        function u10.Enable(p37) -- Line: 161
            -- upvalues: u10 (copy)
            u10.Reference:SetAttribute("Enabled", true);
        end;

        function u10.Disable(p38) -- Line: 165
            -- upvalues: u10 (copy)
            u10.Reference:SetAttribute("Enabled", false);
        end;

        function u10.Destroy(p39) -- Line: 169
            -- upvalues: u10 (copy)
            if table.isfrozen(u10) then
                return;
            end;

            u10.Collector:Destroy();

            for i, v in pairs(u10) do
                if typeof(v) ~= "function" then
                    u10[i] = nil;
                end;
            end;

            table.freeze(u10);
        end;

        if Player == nil or RunService:IsClient() then
            local function UpdateState() -- Line: 185
                -- upvalues: u10 (copy), u5 (copy), RunService (ref)
                if u10.Reference:GetAttribute("Enabled") then
                    u10.Connection = u5:Connect(RunService.Stepped, function(p40) -- Line: 187
                        -- upvalues: u10 (ref)
                        u10:Update(p40);

                        if not u10.Reference:GetAttribute("Enabled") and u10.Connection then
                            u10.Connection:Disconnect();
                            u10.Connection = nil;
                        end;
                    end);
                end;
            end;

            if u10.Reference:GetAttribute("Enabled") then
                u10.Connection = u5:Connect(RunService.Stepped, function(p41) -- Line: 187
                    -- upvalues: u10 (copy)
                    u10:Update(p41);

                    if not u10.Reference:GetAttribute("Enabled") and u10.Connection then
                        u10.Connection:Disconnect();
                        u10.Connection = nil;
                    end;
                end);
            end;

            u5:Connect(u10.Reference:GetAttributeChangedSignal("Enabled"), UpdateState);
        elseif Player and RunService:IsServer() then
            u10.Effect = FXService.CreateEffect({
                Clients = { Player },
                Character = Character,
                Effect = u3,
                Reference = Reference
            });
        end;

        return u10;
    end;
end;

function v1.Start(p42) -- Line: 212
end;

return v1;