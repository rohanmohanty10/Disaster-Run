  

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local u1 = false;
local v2 = RunService:IsServer();
local v3 = RunService:IsClient();
local v4 = RunService:IsStudio();
local v5 = game.JobId ~= "";
pcall(function() -- Line: 16
    -- upvalues: u1 (ref), RunService (copy)
    u1 = RunService:IsEdit();
end);
local table_freeze = table.freeze;
local v6 = {
    IsRCC = v5 and v2,
    IsEdit = u1
};
local v7;

if v4 then
    v7 = not u1;
else
    v7 = v4;
end;

v6.IsTestRun = v7;
v6.IsServer = v2;
v6.IsClient = v3;
v6.IsStudio = v4;
v6.IsOnline = v5;
v6.IsTenFoot = GuiService:IsTenFootInterface();
v6.IsTouch = UserInputService.TouchEnabled;
v6.IsVR = VRService.VREnabled;

return table_freeze(v6);