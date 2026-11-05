-- StarterPlayer > StarterPlayerScripts > ServerBrowserClient   (LocalScript, client)
--
-- The Servers menu: Heroes Battlegrounds' server list, in the style of the other menus
-- (ReplicatedStorage.Modules.ExpeditionUI):
--   header   Ranked / Public / Private
--   left     Create Server, Quick Join, sort, refresh
--   right    "last refreshed", then the servers (this one on top as CURRENT): name and owner,
--            players, a signal estimate, its key and where it is. Click one to join it.
--   bottom   join with a server key, invite a friend
-- Ranked joins the Ranked Lobby through your existing JoinRankedLobby remote.
-- The lists, keys and teleports are ServerScriptService > Systems > ServerBrowserService
-- (ReplicatedStorage.Remotes.Servers). Opened by the Ranked button in the top bar, on the Public
-- tab (shared.servergui("Public")).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalizationService = game:GetService("LocalizationService")
local SocialService = game:GetService("SocialService")

local Player = Players.LocalPlayer
local PlaceRole = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole"))
if not PlaceRole.IsMain() then
	return -- no server list in the Ranked Lobby or Arena
end

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServerRemotes = Remotes:WaitForChild("Servers")
local ListRemote: RemoteFunction = ServerRemotes:WaitForChild("List")
local JoinRemote: RemoteFunction = ServerRemotes:WaitForChild("Join")
local CreateRemote: RemoteFunction = ServerRemotes:WaitForChild("Create")
local JoinRanked: RemoteFunction = Remotes:WaitForChild("JoinRankedLobby")

------------------------------------------------------------------------
-- Look
------------------------------------------------------------------------
local RGB = Color3.fromRGB
local THEME = ColorSequence.new(RGB(232, 226, 214), RGB(150, 142, 130))
local RANKED = ColorSequence.new(RGB(236, 176, 166), RGB(150, 72, 62))
local GOOD, OKAY, POOR = RGB(130, 210, 100), RGB(230, 196, 90), RGB(90, 88, 84)
local SCROLLBAR = RGB(176, 170, 160)
local CURRENT_EDGE = RGB(200, 194, 182)

local SIDE_WIDTH, GAP, BOTTOM_HEIGHT, ROW_HEIGHT = 230, 14, 52, 90
local AUTO_REFRESH = 30 -- seconds, while the menu is open

local Menu = UI.Window({ Name = "ServersUI", Title = "Servers", Gradient = THEME })

-- a country code (US) as its flag emoji
local function Flag(Code: string?): string
	if type(Code) ~= "string" or #Code ~= 2 then
		return ""
	end
	local A, B = string.byte(string.upper(Code), 1, 2)
	return utf8.char(0x1F1E6 + A - 65, 0x1F1E6 + B - 65)
end

-- Top right: where this server is and its key, e.g. "🇺🇸 California • RD4812" (JJS shows the
-- region there); just the country ("🇺🇸 US") when the server couldn't look up its region.
-- Set by ServerBrowserService on workspace; a label, not a button.
local Icon = require(ReplicatedStorage.Modules:WaitForChild("Icon"))
local InfoIcon = Icon.new()
InfoIcon:setName("ServerInfo")
InfoIcon:align("Right")
InfoIcon:lock()
local function RefreshInfo()
	local Country = workspace:GetAttribute("ServerCountry")
	local Region = workspace:GetAttribute("ServerRegion")
	local Key = workspace:GetAttribute("ServerKey")
	local Parts = {}
	if type(Country) == "string" and Country ~= "" then
		local Place = if type(Region) == "string" and Region ~= "" then Region else Country
		table.insert(Parts, `{Flag(Country)} {Place}`)
	end
	if type(Key) == "string" and Key ~= "" then
		table.insert(Parts, Key)
	end
	InfoIcon:setLabel(table.concat(Parts, "  •  "))
	InfoIcon:setEnabled(#Parts > 0)
end
RefreshInfo()
workspace:GetAttributeChangedSignal("ServerCountry"):Connect(RefreshInfo)
workspace:GetAttributeChangedSignal("ServerKey"):Connect(RefreshInfo)
workspace:GetAttributeChangedSignal("ServerRegion"):Connect(RefreshInfo)

local MyCountry: string? = nil
task.spawn(function()
	local Ok, Country = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, Player)
	if Ok then
		MyCountry = Country
	end
end)

------------------------------------------------------------------------
-- State
------------------------------------------------------------------------
local Tab = "Public" -- "Ranked" / "Public" / "Private"
local SORTS = { "Most players", "Fewest players", "Newest" }
local Sort = 1
local Data: { [string]: any } = {}
local RefreshedAt: { [string]: number } = {}
local Fetching: { [string]: boolean } = {}
local Render -- defined below
local SelectTab -- defined below

------------------------------------------------------------------------
-- Layout
------------------------------------------------------------------------
local ListPage = UI.New("Frame", { Name = "Lists", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = Menu.Body })
local RankedPage = UI.New("Frame", { Name = "Ranked", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, Parent = Menu.Body })

-- left: the side buttons
local Side = UI.New("Frame", { Size = UDim2.new(0, SIDE_WIDTH, 1, 0), BackgroundTransparency = 1, Parent = ListPage }, {
	UI.New("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
})

-- right: the list
local Panel = UI.New("Frame", {
	Size = UDim2.new(1, -(SIDE_WIDTH + GAP), 1, -(BOTTOM_HEIGHT + GAP)),
	Position = UDim2.fromOffset(SIDE_WIDTH + GAP, 0),
	BackgroundColor3 = UI.Colors.Panel,
	BackgroundTransparency = 0.2,
	Parent = ListPage,
}, { UI.Corner(10), UI.Stroke(UI.Colors.DarkGray, 2) })
local RefreshedText = UI.Text({
	Text = "",
	TextSize = 16,
	TextColor3 = UI.Colors.LightGray,
	TextXAlignment = Enum.TextXAlignment.Center,
	RichText = true,
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.fromOffset(0, 4),
	Parent = Panel,
})
local List = UI.Scroller(Panel, { Size = UDim2.new(1, -12, 1, -40), Position = UDim2.fromOffset(6, 36), Color = SCROLLBAR, Padding = 8 })
local Empty = UI.Text({
	Text = "",
	TextSize = 20,
	TextColor3 = UI.Colors.Gray,
	TextXAlignment = Enum.TextXAlignment.Center,
	Size = UDim2.new(1, 0, 0, 40),
	Position = UDim2.fromScale(0, 0.42),
	Visible = false,
	Parent = Panel,
})

-- bottom: server key + invite
local Bottom = UI.New("Frame", {
	Size = UDim2.new(1, -(SIDE_WIDTH + GAP), 0, BOTTOM_HEIGHT),
	Position = UDim2.new(0, SIDE_WIDTH + GAP, 1, -BOTTOM_HEIGHT),
	BackgroundTransparency = 1,
	Parent = ListPage,
})
local KeyBox = UI.New("Frame", {
	Size = UDim2.new(0.62, -10, 1, 0),
	BackgroundColor3 = UI.Colors.DarkerGray,
	Parent = Bottom,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Text({ Text = "🔑", TextSize = 22, NoStroke = true, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromOffset(40, 52), Parent = KeyBox })
local KeyInput = UI.New("TextBox", {
	Size = UDim2.new(1, -150, 1, 0),
	Position = UDim2.fromOffset(42, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Server key...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Bold"),
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	Parent = KeyBox,
})

------------------------------------------------------------------------
-- Joining
------------------------------------------------------------------------
local Joining = false
local function Join(Kind: string, Value: string?, Label: string)
	if Joining then
		return
	end
	Joining = true
	UI.Notify(`Teleporting to {Label}...`, "SERVERS")
	local Called, Ok, Message = pcall(JoinRemote.InvokeServer, JoinRemote, Kind, Value)
	if not Called then
		UI.Toast("The servers didn't answer. Try again.", false)
	elseif not Ok then
		UI.Toast(if typeof(Message) == "string" then Message else "Couldn't join that server.", false)
	end
	-- a teleport takes a moment; don't let the button be spammed meanwhile
	task.delay(if Called and Ok then 8 else 1, function()
		Joining = false
	end)
end

UI.Button({
	Parent = KeyBox,
	Size = UDim2.fromOffset(96, 40),
	Position = UDim2.new(1, -6, 0.5, 0),
	AnchorPoint = Vector2.new(1, 0.5),
	Gradient = UI.Gradients.Green,
	Text = "Join",
	TextSize = 18,
	OnClick = function()
		local Key = KeyInput.Text:gsub("%s", "")
		if #Key < 4 then
			UI.Toast("Type a server key first.", false)
			return
		end
		Join("Key", Key, string.upper(Key))
	end,
})

UI.Button({
	Parent = Bottom,
	Size = UDim2.new(0.38, 0, 1, 0),
	Position = UDim2.fromScale(1, 0),
	AnchorPoint = Vector2.new(1, 0),
	Text = "Invite Friend",
	TextSize = 18,
	OnClick = function()
		local Ok, Can = pcall(SocialService.CanSendGameInviteAsync, SocialService, Player)
		if Ok and Can then
			pcall(SocialService.PromptGameInvite, SocialService, Player)
		else
			UI.Toast("You can't send invites right now.", false)
		end
	end,
})

------------------------------------------------------------------------
-- Rows
------------------------------------------------------------------------
-- Signal bars plus a ping label, like HBG. This server shows your real ping in ms; other servers
-- get a rough estimate (same country as you is best), since the game can't measure ping to them.
local QUALITY = { "Okay", "Good", "Great" }
local function LevelColor(Level: number): Color3
	return if Level >= 3 then GOOD elseif Level == 2 then OKAY else POOR
end
local function Signal(Parent: Instance, Position: UDim2, Level: number)
	local Holder = UI.New("Frame", { Size = UDim2.fromOffset(26, 22), Position = Position, BackgroundTransparency = 1, Parent = Parent })
	local Bars = {}
	for Bar = 1, 3 do
		Bars[Bar] = UI.New("Frame", {
			Size = UDim2.fromOffset(6, 6 + Bar * 5),
			Position = UDim2.new(0, (Bar - 1) * 9, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			Parent = Holder,
		}, { UI.Corner(2) })
	end
	local function SetLevel(NewLevel: number)
		for Bar, Frame in Bars do
			Frame.BackgroundColor3 = if Bar <= NewLevel then LevelColor(NewLevel) else POOR
			Frame.BackgroundTransparency = if Bar <= NewLevel then 0 else 0.5
		end
	end
	SetLevel(Level)
	return SetLevel
end

-- your round-trip ping to this server, in ms
local function MyPing(): number
	return math.floor(Player:GetNetworkPing() * 1000 + 0.5)
end

local function ServerRow(Kind: string, Server: any, Order: number, IsCurrent: boolean, Number: number)
	local Title = if IsCurrent then "CURRENT" elseif Kind == "Public" then `PUBLIC #{Number}` else tostring(Server.Name)
	local Subtitle = if Kind == "Public" then "Public Server" else `By {Server.Owner}`
	local Root = UI.New("TextButton", { Name = tostring(Server.Key), Size = UDim2.new(1, 0, 0, ROW_HEIGHT), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Order, Parent = List })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		Parent = Root,
	}, { UI.Corner(10), UI.Stroke(if IsCurrent then CURRENT_EDGE else UI.Colors.DarkGray, 2) })

	-- left: name
	local Name = UI.Text({ Text = Title, TextSize = 28, Weight = "ExtraBold", TextScaled = true, TextXAlignment = Enum.TextXAlignment.Center, Gradient = if IsCurrent then nil else THEME, Size = UDim2.new(0.4, -20, 0, 34), Position = UDim2.fromOffset(10, 14), Parent = Visual })
	UI.New("UITextSizeConstraint", { MaxTextSize = 28, Parent = Name })
	UI.Text({ Text = Subtitle, TextSize = 17, NoStroke = true, TextColor3 = UI.Colors.LightGray, TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(0.4, -20, 0, 22), Position = UDim2.fromOffset(10, 54), Parent = Visual })
	UI.New("Frame", { Size = UDim2.new(0, 2, 1, -20), Position = UDim2.new(0.4, 0, 0, 10), BackgroundColor3 = UI.Colors.DarkGray, Parent = Visual })

	-- right: players, signal, key / where
	local Full = (Server.Players or 0) >= (Server.Max or 1)
	UI.Text({ Text = `👥 {Server.Players or 0}/{Server.Max or "?"}`, TextSize = 22, TextColor3 = if Full then UI.Colors.Red else UI.Colors.White, Size = UDim2.new(0.16, -10, 0, 28), Position = UDim2.new(0.4, 18, 0, 14), Parent = Visual })
	local Level = if IsCurrent then 3 elseif not Server.Country or not MyCountry then 1 elseif Server.Country == MyCountry then 3 else 2
	local SetLevel = Signal(Visual, UDim2.new(0.58, 0, 0, 18), Level)
	local Ping = UI.Text({ Text = QUALITY[Level], TextSize = 22, TextColor3 = LevelColor(Level), Size = UDim2.new(0.16, -32, 0, 28), Position = UDim2.new(0.58, 34, 0, 14), Parent = Visual })
	if IsCurrent then
		-- live, while the row is on screen
		task.spawn(function()
			while Ping.Parent do
				local Ms = MyPing()
				local Now = if Ms <= 90 then 3 elseif Ms <= 180 then 2 else 1
				Ping.Text = `{Ms}ms`
				Ping.TextColor3 = if Now == 1 then UI.Colors.Red else LevelColor(Now)
				SetLevel(Now)
				task.wait(1)
			end
		end)
	end
	UI.Text({ Text = tostring(Server.Key), TextSize = 24, Size = UDim2.new(0.26, -16, 0, 28), Position = UDim2.new(0.74, 0, 0, 14), Parent = Visual })
	local Where = if Server.Region and Server.Country then `📍 {Server.Region}, {Server.Country} {Flag(Server.Country)}`
		elseif Server.Country then `📍 {Server.Country} {Flag(Server.Country)}`
		else "📍 Unknown region"
	UI.Text({ Text = Where, TextSize = 18, NoStroke = true, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(0.6, -30, 0, 24), Position = UDim2.new(0.4, 18, 0, 52), Parent = Visual })

	local Hover = UI.HoverStroke(Visual, THEME, 2, 10)
	UI.Bouncy(Root, Visual, { Grow = 0.01, HoverStroke = Hover })
	Root.Activated:Connect(function()
		UI.Play("Click", 0.4)
		if IsCurrent then
			UI.Toast("You're already in this server.", false)
		elseif Full then
			UI.Toast("That server is full.", false)
		else
			Join(Kind, if Kind == "Public" then Server.Id else Server.Key, Title)
		end
	end)
end

local function Sorted(Servers: { any }): { any }
	local Copy = table.clone(Servers)
	table.sort(Copy, function(A, B)
		if Sort == 1 then
			return (A.Players or 0) > (B.Players or 0)
		elseif Sort == 2 then
			return (A.Players or 0) < (B.Players or 0)
		end
		return (A.Started or 0) > (B.Started or 0)
	end)
	return Copy
end

Render = function()
	for _, Child in List:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	local Result = Data[Tab]
	if not Result then
		Empty.Text = "Loading servers..."
		Empty.Visible = true
		return
	end
	local Order = 0
	local CurrentId = Result.Current and Result.Current.Id
	if Result.Current then
		Order += 1
		ServerRow(Tab, Result.Current, Order, true, 0)
	end
	local Number = 0
	for _, Server in Sorted(Result.Servers or {}) do
		if Server.Id ~= CurrentId then
			Order += 1
			Number += 1
			ServerRow(Tab, Server, Order, false, Number)
		end
	end
	Empty.Text = if Tab == "Private" then "No private servers yet. Create one!" else "No other servers right now."
	Empty.Visible = Order == 0
end

local function Fetch(Kind: string)
	if Fetching[Kind] then
		return
	end
	Fetching[Kind] = true
	local Ok, Result = pcall(ListRemote.InvokeServer, ListRemote, Kind)
	Fetching[Kind] = false
	if Ok and type(Result) == "table" then
		Data[Kind] = Result
		RefreshedAt[Kind] = os.clock()
	end
	if Tab == Kind and Menu.IsOpen then
		Render()
	end
end

-- "LAST REFRESHED : 4s ago", and the auto refresh while open
task.spawn(function()
	while true do
		task.wait(1)
		if Menu.IsOpen and Tab ~= "Ranked" then
			local At = RefreshedAt[Tab]
			local Ago = if At then math.floor(os.clock() - At) else nil
			RefreshedText.Text = if Ago then `<b>LAST REFRESHED</b> : {Ago}s ago` else "<b>LOADING...</b>"
			if Ago and Ago >= AUTO_REFRESH then
				task.spawn(Fetch, Tab)
			end
		end
	end
end)

------------------------------------------------------------------------
-- Side buttons
------------------------------------------------------------------------
local CreateVeil -- defined below

local function SideButton(Text: string, Order: number, OnClick: () -> ())
	return UI.Button({ Parent = Side, Size = UDim2.new(1, 0, 0, 50), Text = Text, TextSize = 19, LayoutOrder = Order, Grow = 0.04, OnClick = OnClick })
end
SideButton("+ Create Server", 1, function()
	SelectTab("Private")
	CreateVeil.Visible = true
end)
SideButton("Quick Join", 2, function()
	Join("Quick", nil, "a server")
end)
local SortButton
SortButton = SideButton("", 3, function()
	Sort = Sort % #SORTS + 1
	SortButton.Label.Text = `Sort: {SORTS[Sort]}`
	Render()
end)
SortButton.Label.Text = `Sort: {SORTS[Sort]}`
local LastManualRefresh = 0
SideButton("Refresh", 4, function()
	if os.clock() - LastManualRefresh < 3 then
		return
	end
	LastManualRefresh = os.clock()
	task.spawn(Fetch, Tab)
end)

------------------------------------------------------------------------
-- Create Server panel
------------------------------------------------------------------------
CreateVeil = UI.New("TextButton", {
	Name = "CreateVeil",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = UI.Colors.Black,
	BackgroundTransparency = 0.45,
	Text = "",
	AutoButtonColor = false,
	ZIndex = 50,
	Visible = false,
	Parent = Menu.Window,
}, { UI.Corner(12) })
local CreatePanel = UI.New("Frame", {
	Size = UDim2.fromOffset(460, 290),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = UI.Colors.Panel,
	ZIndex = 51,
	Parent = CreateVeil,
}, { UI.Corner(12), UI.Stroke(UI.Colors.Black, 4) })
UI.Text({ Text = "Create Server", TextSize = 28, Weight = "ExtraBold", Gradient = THEME, Size = UDim2.new(1, -80, 0, 34), Position = UDim2.fromOffset(18, 14), ZIndex = 52, Parent = CreatePanel })
local CreateNote = UI.Text({ Text = "", TextSize = 15, NoStroke = true, TextWrapped = true, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(1, -36, 0, 40), Position = UDim2.fromOffset(18, 52), TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 52, Parent = CreatePanel })
local NameBox = UI.New("Frame", { Size = UDim2.new(1, -36, 0, 46), Position = UDim2.fromOffset(18, 100), BackgroundColor3 = UI.Colors.DarkerGray, ZIndex = 52, Parent = CreatePanel }, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
local NameInput = UI.New("TextBox", {
	Size = UDim2.new(1, -24, 1, 0),
	Position = UDim2.fromOffset(12, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Server name...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Medium"),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	ZIndex = 53,
	Parent = NameBox,
})
-- after creating: the key to share, and a button to go there
local MadeKey = UI.Text({ Text = "", TextSize = 34, Weight = "ExtraBold", TextXAlignment = Enum.TextXAlignment.Center, Gradient = THEME, Size = UDim2.new(1, -36, 0, 40), Position = UDim2.fromOffset(18, 156), ZIndex = 52, Visible = false, Parent = CreatePanel })
local Made: any = nil
local CreateButton
CreateButton = UI.Button({
	Parent = CreatePanel,
	Size = UDim2.new(1, -36, 0, 50),
	Position = UDim2.new(0, 18, 1, -16),
	AnchorPoint = Vector2.new(0, 1),
	Gradient = UI.Gradients.Green,
	Text = "Create",
	TextSize = 22,
	OnClick = function()
		if Made then
			Join("Private", Made.Key, Made.Name)
			return
		end
		CreateButton.Label.Text = "Creating..."
		local Called, Ok, Result = pcall(CreateRemote.InvokeServer, CreateRemote, NameInput.Text)
		if Called and Ok and type(Result) == "table" then
			Made = Result
			MadeKey.Text = Result.Key
			MadeKey.Visible = true
			CreateNote.Text = `"{Result.Name}" is ready. Share this key so friends can join, or find it under Private.`
			CreateButton.Label.Text = "Join It"
			task.spawn(Fetch, "Private")
		else
			CreateButton.Label.Text = "Create"
			UI.Toast(if Called and typeof(Result) == "string" then Result else "Couldn't create a server.", false)
		end
	end,
})
CreateButton.Root.ZIndex = 52
UI.IconButton(CreatePanel, UI.Images.Close, 40, UI.Gradients.Red, UDim2.new(1, -54, 0, 14), function()
	CreateVeil.Visible = false
end).Root.ZIndex = 53
CreateVeil:GetPropertyChangedSignal("Visible"):Connect(function()
	if CreateVeil.Visible then
		Made = nil
		NameInput.Text = ""
		MadeKey.Visible = false
		CreateNote.Text = "A free server just for you and your friends. Making a new one replaces your old one."
		CreateButton.Label.Text = "Create"
	end
end)

------------------------------------------------------------------------
-- Ranked
------------------------------------------------------------------------
local RankedCard = UI.New("Frame", {
	Size = UDim2.new(0.6, 0, 0.7, 0),
	Position = UDim2.fromScale(0.5, 0.45),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = UI.Colors.Card,
	ClipsDescendants = true,
	Parent = RankedPage,
}, { UI.Corner(12), UI.Stroke(UI.Colors.DarkGray, 2) })
local RankedWash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, Parent = RankedCard }, { UI.Corner(12) })
UI.New("UIGradient", { Color = RANKED, Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 1) }), Parent = RankedWash })
UI.Text({ Text = "RANKED", TextSize = 48, Weight = "ExtraBold", TextXAlignment = Enum.TextXAlignment.Center, Gradient = RANKED, Size = UDim2.new(1, -40, 0, 56), Position = UDim2.fromOffset(20, 30), Parent = RankedCard })
UI.Text({
	Text = "Fight for Elo against players at your level. You'll go to the Ranked Lobby, where you can queue alone or with a party.",
	TextSize = 19,
	NoStroke = true,
	TextWrapped = true,
	TextColor3 = UI.Colors.LightGray,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Top,
	Size = UDim2.new(1, -80, 0, 80),
	Position = UDim2.fromOffset(40, 100),
	Parent = RankedCard,
})
local RankedBusy = false
local RankedButton
RankedButton = UI.Button({
	Parent = RankedCard,
	Size = UDim2.new(0.6, 0, 0, 60),
	Position = UDim2.new(0.5, 0, 1, -30),
	AnchorPoint = Vector2.new(0.5, 1),
	Gradient = RANKED,
	Text = "Join Ranked Lobby",
	TextSize = 24,
	OnClick = function()
		if RankedBusy then
			return
		end
		RankedBusy = true
		RankedButton.Label.Text = "Joining..."
		-- the server decides (combat, cooldown) and shows any message as a notification
		local Ok, Accepted = pcall(JoinRanked.InvokeServer, JoinRanked)
		if Ok and Accepted then
			task.wait(15) -- if the teleport stalls, the button comes back
		end
		RankedButton.Label.Text = "Join Ranked Lobby"
		RankedBusy = false
	end,
})

------------------------------------------------------------------------
-- Tabs
------------------------------------------------------------------------
local SelectHeader = UI.Tabs(Menu.Window, { "Ranked", "Public", "Private" }, THEME, function(Name)
	Tab = Name
	RankedPage.Visible = Name == "Ranked"
	ListPage.Visible = Name ~= "Ranked"
	if Name ~= "Ranked" then
		Render()
		local At = RefreshedAt[Name]
		if not At or os.clock() - At > 10 then
			task.spawn(Fetch, Name)
		end
	end
end, {
	Size = UDim2.new(0.54, 0, 0, 42),
	Position = UDim2.new(0.42, -30, 0, 14),
})
SelectTab = function(Name: string)
	SelectHeader(Name)
end

Menu.OnOpen = function()
	CreateVeil.Visible = false
	SelectTab(Tab)
end

UI.Own("servergui", function(Name: string?)
	if Name == "Ranked" or Name == "Public" or Name == "Private" then
		Tab = Name
	end
	if Menu.IsOpen then
		Menu:SetOpen(false) -- the top-bar button closes it again, like the others
	else
		Menu:SetOpen(true)
	end
end)
