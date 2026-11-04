  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"));
local environment = require(ReplicatedStorage.Shared.environment);
local u1 = {
    wctesttopreward = true,
    wcresettestreward = true
};
require(ReplicatedStorage.CmdrConfig.Types)(CmdrClient.Registry);
CmdrClient.Registry:RegisterCommandsIn(ReplicatedStorage.CmdrConfig.Commands, function(p2) -- Line: 9, Name: shouldRegisterCommand
    -- upvalues: environment (copy), u1 (copy)
    return environment.env == "Dev" and true or not u1[p2.Name];
end);
CmdrClient:SetActivationKeys({ Enum.KeyCode.At, Enum.KeyCode.F2 });
local TextChatService = game:GetService("TextChatService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function openCmdr() -- Line: 25
    -- upvalues: CmdrClient (copy)
    CmdrClient:Show();
    task.defer(function() -- Line: 27
        -- upvalues: CmdrClient (ref)
        if CmdrClient.Enabled then
            CmdrClient:Show();
        end;
    end);
end;

task.spawn(function() -- Line: 34
    -- upvalues: TextChatService (copy), LocalPlayer (copy), CmdrClient (copy)
    local CmdrCommand = TextChatService:WaitForChild("CmdrCommand", 10);

    if not CmdrCommand then
        return;
    end;

    CmdrCommand.Triggered:Connect(function(p3) -- Line: 37
        -- upvalues: LocalPlayer (ref), CmdrClient (ref)
        if p3 and p3.UserId ~= LocalPlayer.UserId then
            return;
        end;

        CmdrClient:Show();
        task.defer(function() -- Line: 27
            -- upvalues: CmdrClient (ref)
            if CmdrClient.Enabled then
                CmdrClient:Show();
            end;
        end);
    end);
end);
TextChatService.SendingMessage:Connect(function(p4) -- Line: 43
    -- upvalues: CmdrClient (copy)
    if p4.Text == "/cmd" or p4.Text == "/cmdr" then
        CmdrClient:Show();
        task.defer(function() -- Line: 27
            -- upvalues: CmdrClient (ref)
            if CmdrClient.Enabled then
                CmdrClient:Show();
            end;
        end);
    end;
end);