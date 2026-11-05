-- Replace the existing ShopService Script's source. Uses your existing item delivery system.
local Players=game:GetService("Players")
local RS=game:GetService("ReplicatedStorage")
local SS=game:GetService("ServerStorage")
local Config=require(RS.Modules:WaitForChild("ShopConfig"))
local DataManager=require(game:GetService("ServerScriptService").Data.DataManager)
local function make(class,name,parent)
	local object=parent:FindFirstChild(name) or Instance.new(class)
	object.Name=name;object.Parent=parent
	return object
end
local folder=make("Folder","Shop",RS:WaitForChild("Remotes"))
local purchase=make("RemoteFunction","Purchase",folder)
make("RemoteEvent","Notify",folder)
local ItemService=require(SS.SBGModules:WaitForChild("ItemService"))
local ItemConfig=require(RS.Modules.ItemConfig)
local lastPurchase={}
local rng=Random.new()
local function roll()
	local total=0
	for id,weight in Config.Crate.Odds do
		if not Config.GetItem(id) or not ItemConfig.Get(id) or weight<=0 then return nil end
		total+=weight
	end
	if total<=0 then return nil end
	local pick=rng:NextNumber(0,total)
	for id,weight in Config.Crate.Odds do pick-=weight;if pick<=0 then return id end end
	return next(Config.Crate.Odds)
end
purchase.OnServerInvoke=function(player,kind,id,amount)
	if type(kind)~="string" or type(amount)~="number" or not table.find(Config.AmountOptions,amount) then
		return false,"That purchase isn't valid."
	end
	local now=os.clock()
	if now-(lastPurchase[player] or -math.huge)<Config.PurchaseCooldown then return false,"Please wait a moment." end
	lastPurchase[player]=now
	local price,ids
	-- items are only sold at random, through the crate (no picking a specific item)
	if kind=="Crate" then
		price=Config.Crate.Price;ids={}
		for _=1,amount do
			local item=roll()
			if not item then return false,"The crate is unavailable." end
			table.insert(ids,item)
		end
	elseif kind=="Spin" and id==Config.EmoteSpin.Id then
		price=Config.EmoteSpin.Price
	else
		return false,"That purchase isn't valid."
	end
	local profile=DataManager.Profiles[player]
	if not profile or (profile.IsActive and not profile:IsActive()) then return false,"Your data is still loading." end
	if kind~="Spin" then
		local character=player.Character
		local humanoid=character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health<=0 or not character:FindFirstChild("HumanoidRootPart") then
			return false,"Respawn before ordering a delivery."
		end
	end
	local cost=price*amount
	local gold=DataManager.getGold(player)
	if not gold or gold<cost then return false,"You need "..(cost-(gold or 0)).." more Gold." end
	if not DataManager.addGold(player,-cost) then return false,"Couldn't take the Gold. Try again." end
	if kind=="Spin" then
		DataManager.addEmoteSpins(player,amount)
		return true,{"EmoteSpin"}
	end
	task.delay(Config.DeliveryTime,function()
		if player.Parent~=Players then return end
		local character=player.Character
		local humanoid=character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health<=0 or not character:FindFirstChild("HumanoidRootPart") then
			DataManager.addGold(player,cost)
			folder.Notify:FireClient(player,"Refund","Delivery canceled; "..cost.." Gold returned.")
			return
		end
		ItemService.Deliver(player,ids)
	end)
	return true,ids
end
Players.PlayerRemoving:Connect(function(player) lastPurchase[player]=nil end)

-- Items bought with Robux or gifted (DataManager.addPendingItems) are saved in PendingItems until
-- the player is alive, then a seagull brings them like a Gold purchase. Main game only, not the
-- Ranked Lobby or Arena.
local PlaceRole=require(RS:WaitForChild("Ranked"):WaitForChild("PlaceRole"))
local function deliverPending(player)
	local profile=DataManager.Profiles[player]
	local pending=profile and profile.Data.PendingItems
	if not pending or #pending==0 then return end
	local character=player.Character
	local humanoid=character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health<=0 or not character:FindFirstChild("HumanoidRootPart") then return end
	local ids={}
	for _,id in pending do
		if id==Config.Crate.Id then id=roll() end
		if id and ItemConfig.Get(id) then table.insert(ids,id) end
	end
	table.clear(pending)
	if #ids>0 then
		RS.Remotes.Comunicator.Set:FireClient(player,"SendNotification",{Title="DELIVERY",Text="A seagull is bringing your item!",Time=5})
		ItemService.Deliver(player,ids)
	end
end
if PlaceRole.IsMain() then
	task.spawn(function()
		while true do
			task.wait(2)
			for _,player in Players:GetPlayers() do task.spawn(deliverPending,player) end
		end
	end)
end
