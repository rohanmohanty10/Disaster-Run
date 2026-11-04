 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.packets);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.forum.trove);
local Parent = script.Parent.Parent;

return {
    Attachments = {
        Ping = function(p1, p2, p3) -- Line: 25, Name: Ping
            p1:destroyContainer();
            p1.baseClient:senduse({ "ping", p3, p2 });
        end,

        LongPing = function(u4, u5) -- Line: 31, Name: LongPing
            -- upvalues: UserInputService (copy)
            u4:destroyContainer();
            local u6 = u4:createContainer();

            if not u6 then
                return;
            end;

            local Frame = u4.playerGui.Notification.Frame;
            local v7, u8;

            if UserInputService.MouseEnabled then
                v7 = "Click a position";
                u8 = "Click";
            elseif UserInputService.GamepadEnabled then
                v7 = "Look at a position and use your B button";
                u8 = "B";
            else
                if not UserInputService.TouchEnabled then
                    return;
                end;

                v7 = "Tap a position";
                u8 = "Touch";
            end;

            local v9 = Frame.base:Clone();
            v9.TextLabel.Text = `{v7} to ping for {string.lower(u5)}`;
            v9.Visible = true;
            v9.Parent = Frame;
            u6:Add(v9);
            u6:Connect(UserInputService.InputBegan, function(p10: userdata) -- Line: 61
                -- upvalues: u8 (ref), u6 (copy), u4 (copy), u5 (copy)
                local v11;

                if u8 == "Click" and p10.UserInputType == Enum.UserInputType.MouseButton1 or u8 == "B" and p10.KeyCode == Enum.KeyCode.ButtonB then
                    v11 = true;
                elseif u8 == "Touch" then
                    v11 = p10.UserInputType == Enum.UserInputType.Touch;
                else
                    v11 = false;
                end;

                if v11 then
                    u6:Destroy();
                    u4:Ping(u5, u4.player:GetMouse().Hit.Position);
                end;
            end);
        end,

        Comms = function(u12) -- Line: 73, Name: Comms
            -- upvalues: Parent (copy), soundUtil (copy)
            u12:destroyContainer();
            local v13 = u12:createContainer();

            if not v13 then
                return;
            end;

            u12.commsWasOpen = true;
            local v14 = v13:Clone(Parent.Comms);
            v14.Parent = u12.playerGui;
            local ImageLabel = v14.ImageLabel;
            v13:Connect(ImageLabel.Emotes.Button.MouseButton1Click, function() -- Line: 86
                -- upvalues: soundUtil (ref), u12 (copy)
                soundUtil:play("click", "default");
                u12:destroyContainer();
                u12.commsWasOpen = nil;
                u12:Emote();
            end);

            for _, child in ImageLabel:GetChildren() do
                if child:FindFirstChild("EmoteName") then
                    local Button = child.Button;
                    local u15 = nil;

                    local function v16() -- Line: 106
                        -- upvalues: u15 (ref), soundUtil (ref), u12 (copy), child (copy)
                        if not u15 or coroutine.status(u15) ~= "suspended" then
                            return;
                        end;

                        task.cancel(u15);
                        u15 = nil;
                        soundUtil:play("click", "default");
                        u12:Ping(child.Name, u12.character:GetPivot().Position);
                    end;

                    v13:Connect(Button.MouseButton1Down, function() -- Line: 97
                        -- upvalues: u15 (ref), soundUtil (ref), u12 (copy), child (copy)
                        u15 = task.delay(0.2, function() -- Line: 98
                            -- upvalues: u15 (ref), soundUtil (ref), u12 (ref), child (ref)
                            u15 = nil;
                            soundUtil:play("click", "default");
                            u12:LongPing(child.Name);
                        end);
                    end);
                    v13:Connect(Button.MouseButton1Up, v16);
                    v13:Connect(Button.MouseButton2Click, function() -- Line: 118
                        -- upvalues: u12 (copy), child (copy)
                        u12:LongPing(child.Name);
                    end);
                end;
            end;
        end
    }
};