repeat task.wait() until script and script.Parent


-- services --

local Debris = game:GetService('Debris')
local Players = game:GetService("Players")
local RS = game.ReplicatedStorage


-- remotes --

local Remotes = RS:WaitForChild('Remotes')


local InviteFolder = Remotes:WaitForChild('Invites')

local InviteSet = InviteFolder:WaitForChild('Set')
local InviteGet = InviteFolder:WaitForChild('Get')


-- gui --

local GUI = script.Parent
local Holder = GUI:WaitForChild('Holder')


-- functions --

local function SetNotificationInteraction(NotificationFrame: Frame)
	NotificationFrame.Accept.Activated:Once(function()
		NotificationFrame:SetAttribute('State', 'Accepted')
	end)
	
	NotificationFrame.Deny.Activated:Once(function()
		NotificationFrame:SetAttribute('State', 'Denied')
	end)
end


-- runtime --

InviteGet.OnClientInvoke = function(Action: string, Params: { any })
	if Action == 'Invite' then
		local GUIClone = GUI:Clone()
		GUIClone.Parent = Players.LocalPlayer.PlayerGui
		
		local Notification = script.Notification:Clone()
		Notification.Message.Text = Params.Inviter..' invited you to his group'
		Notification.Parent = Holder
		SetNotificationInteraction(Notification)
		Debris:AddItem(Notification, 5)
		task.delay(5, function()
			if Notification:GetAttribute('State') == 'nil' then
				Notification:SetAttribute('State', 'Denied')
			end
		end)
		
		repeat task.wait() until Notification:GetAttribute('State') ~= 'nil'
		
		local State = Notification:GetAttribute('State')
		Notification:Destroy()
		
		task.wait(1.5)
		
		GUIClone:Destroy()
		
		return State
	end
end