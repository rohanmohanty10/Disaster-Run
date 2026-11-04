 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local UserId = LocalPlayer.UserId;
local permissions = require(ReplicatedStorage.permissions);
local script_Parent = script.Parent;

if game.GameId ~= 7231744796 or (RunService:IsStudio() or (permissions(LocalPlayer).developer or table.find({ 1549164509, 885268917 }, UserId))) then
    script_Parent.Visible = false;

    return;
end;

local UIGridLayout = script_Parent.UIGridLayout;
local ViewportSize = workspace.CurrentCamera.ViewportSize;
local u1 = (ViewportSize.X / (ViewportSize.X * UIGridLayout.CellSize.X.Scale) + 1) * (ViewportSize.Y / (ViewportSize.Y * UIGridLayout.CellSize.Y.Scale) + 1);
local Frame = script_Parent.Template.Frame;
local u2 = {};

local function Update() -- Line: 32
    -- upvalues: u2 (copy), u1 (copy), Frame (copy), UserId (copy), script_Parent (copy)
    for _, v in u2 do
        v:Destroy();
    end;

    table.clear(u2);

    for i = 1, u1 do
        local v3 = Frame:Clone();
        v3.ID.Text = tostring(UserId);
        v3.Parent = script_Parent;
        v3.Visible = true;
        table.insert(u2, v3);
        local _ = i;
    end;
end;

task.spawn(Update);
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(Update);