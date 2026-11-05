  

 

local FakeUserSettings = require(script.Parent:WaitForChild("FakeUserSettings"));

if game["Run Service"]:IsClient() then
    local PlayerModule = game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule");
    local CameraModule = PlayerModule:WaitForChild("CameraModule");
    local TransparencyController = require(CameraModule:WaitForChild("TransparencyController"));
    local u1 = nil;
    local Enable = TransparencyController.Enable;
    local BindableEvent = Instance.new("BindableEvent");

    function TransparencyController.Enable(p2, ...) -- Line: 16
        -- upvalues: Enable (copy), FakeUserSettings (copy), TransparencyController (copy), u1 (ref), BindableEvent (copy)
        Enable(p2, ...);
        local v3 = getfenv(3);
        v3.UserSettings = FakeUserSettings;
        local v4 = setfenv(3, v3);
        TransparencyController.Enable = Enable;
        u1 = v4();
        BindableEvent.Event:Wait();
    end;

    coroutine.wrap(function() -- Line: 29
        -- upvalues: CameraModule (copy)
        require(CameraModule);
    end)();

    for _, child in pairs(CameraModule:GetChildren()) do
        child.Parent = script;
    end;

    CameraModule.Name = "_CameraModule";
    script.Name = "CameraModule";
    script.Parent = PlayerModule;

    return u1;
end;