 
 

local u1 = {};
local script_Shared = script.Shared;
local AvatarEditorService = game:GetService("AvatarEditorService");
local MarketplaceService = game:GetService("MarketplaceService");
local CollectionService = game:GetService("CollectionService");
local DataStoreService = game:GetService("DataStoreService");
local ContentProvider = game:GetService("ContentProvider");
local InsertService = game:GetService("InsertService");
local ServerStorage = game:GetService("ServerStorage");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local Trove = require(script_Shared.Trove);
local Signal = require(script_Shared.Signal);
local Promise = require(script_Shared.Promise);
local Settings = require(script_Shared.Settings);
local RunContext = require(script_Shared.RunContext);
local Playlists = script:FindFirstChild("Playlists");
local u2 = nil;
local u3 = nil;

if RunContext.IsClient and not RunContext.IsEdit then
    local RelicsFunc = script:WaitForChild("RelicsFunc");
    local v4 = RelicsFunc:IsA("RemoteFunction");
    assert(v4, "Expected RelicsFunc to be a RemoteFunction.");
    u2 = RelicsFunc;
    u3 = script:WaitForChild("RelicsEvent");
    local v5 = u3:IsA("RemoteEvent");
    assert(v5, "Expected RelicsEvent to be a RemoteEvent.");
elseif RunContext.IsServer then
    u2 = Instance.new("RemoteFunction");
    u2.Name = "RelicsFunc";
    u2.Archivable = false;
    u2.Parent = script;
    u3 = Instance.new("RemoteEvent");
    u3.Name = "RelicsEvent";
    u3.Archivable = false;
    u3.Parent = script;
end;

local u6;

if RunContext.IsServer then
    u6 = game:GetService("NetworkServer");
else
    u6 = nil;
end;

u1.FavoriteAdded = Signal.new();
u1.FavoriteRemoved = Signal.new();
u1.SettingChanged = Signal.new();
u1.AuraRolled = Signal.new();
u1.AuraUpdated = Signal.new();
u1.OnClientEvent = u3 and u3.OnClientEvent;
u1.OnServerEvent = u3 and u3.OnServerEvent;
local u7 = nil;
pcall(function() -- Line: 93
    -- upvalues: ServerStorage (copy), u7 (ref)
    local RELICS_API_KEY = ServerStorage:FindFirstChild("RELICS_API_KEY");

    if RELICS_API_KEY and RELICS_API_KEY:IsA("StringValue") then
        u7 = RELICS_API_KEY.Value;
    end;
end);

local function relicsGET(u8: string) -- Line: 101
    -- upvalues: Promise (copy), u7 (ref), HttpService (copy)
    return Promise.new(function(p9, p10) -- Line: 102
        -- upvalues: u7 (ref), HttpService (ref), u8 (copy)
        if not u7 then
            p10("RELICS API is unavailable!");

            return;
        end;

        local v11;

        if typeof(u7) == "Secret" then
            v11 = u7:AddPrefix("Basic ");
        else
            v11 = "Basic " .. u7;
        end;

        local v12 = HttpService:RequestAsync({
            Method = "GET",
            Url = "https://api.relics.xyz" .. u8,
            Headers = {
                ["Content-Type"] = "application/json",
                Authorization = v11
            },
            Compress = Enum.HttpCompression.None
        });

        if v12.Success and v12.Body then
            p9(HttpService:JSONDecode(v12.Body));

            return;
        end;

        p10(v12.Body);
    end);
end;

function u1.FireServer(p13: string, ...) -- Line: 136
    -- upvalues: RunContext (copy), u3 (ref)
    if RunContext.IsEdit then
        return;
    end;

    if RunContext.IsClient then
        u3:FireServer(p13, ...);

        return;
    end;

    warn("[RelicsXYZ] FireServer can only be called on the client.");
end;

function u1.FireClient(p14: userdata, p15: string, ...) -- Line: 150
    -- upvalues: RunContext (copy), u3 (ref)
    if RunContext.IsEdit then
        return;
    end;

    if RunContext.IsServer then
        u3:FireClient(p14, p15, ...);

        return;
    end;

    warn("[RelicsXYZ] FireClient can only be called on the server.");
end;

function u1.InvokeServer(p16: string, ...) -- Line: 164
    -- upvalues: u2 (ref)
    return u2:InvokeServer(p16, ...);
end;

local u17 = {};

local function isDemo() -- Line: 180
    -- upvalues: CollectionService (copy)
    local v18 = CollectionService:GetTagged("RelicsFeatures")[1];

    if v18 then
        v18 = v18:GetAttribute("Demo");
    end;

    return v18 and true or false;
end;

local function promiseOwnership(u19: userdata, u20: number, u21: any) -- Line: 185
    -- upvalues: Promise (copy), CollectionService (copy), RunContext (copy), MarketplaceService (copy)
    return Promise.new(function(p22, p23) -- Line: 186
        -- upvalues: u19 (copy), CollectionService (ref), RunContext (ref), u21 (copy), MarketplaceService (ref), u20 (copy)
        if not u19 then
            p23("No player");

            return;
        end;

        local v24 = CollectionService:GetTagged("RelicsFeatures")[1];

        if v24 then
            v24 = v24:GetAttribute("Demo");
        end;

        if v24 or RunContext.IsStudio then
            p22(true);

            return;
        end;

        if u21 == Enum.InfoType.Asset then
            p22(MarketplaceService:PlayerOwnsAsset(u19, u20));

            return;
        end;

        if u21 == Enum.InfoType.GamePass then
            p22(MarketplaceService:UserOwnsGamePassAsync(u19.UserId, u20));

            return;
        end;

        if u21 == Enum.InfoType.Bundle then
            p22(MarketplaceService:PlayerOwnsBundle(u19, u20));

            return;
        end;

        p23("Unsupported info type");
    end);
end;

local function getOwnership(u25: userdata, u26: number, p27: any) -- Line: 209
    -- upvalues: u17 (copy), Promise (copy), CollectionService (copy), RunContext (copy), MarketplaceService (copy)
    local v28 = u17[u25];

    if not v28 then
        v28 = {};
        u17[u25] = v28;
    end;

    local u29 = p27 or Enum.InfoType.Asset;
    local v30 = v28[u29];

    if not v30 then
        v30 = {};
        v28[u29] = v30;
    end;

    local v31 = v30[u26];

    if v31 == nil then
        v31 = Promise.new(function(p32, p33) -- Line: 186
            -- upvalues: u25 (copy), CollectionService (ref), RunContext (ref), u29 (copy), MarketplaceService (ref), u26 (copy)
            if not u25 then
                p33("No player");

                return;
            end;

            local v34 = CollectionService:GetTagged("RelicsFeatures")[1];

            if v34 then
                v34 = v34:GetAttribute("Demo");
            end;

            if v34 or RunContext.IsStudio then
                p32(true);

                return;
            end;

            if u29 == Enum.InfoType.Asset then
                p32(MarketplaceService:PlayerOwnsAsset(u25, u26));

                return;
            end;

            if u29 == Enum.InfoType.GamePass then
                p32(MarketplaceService:UserOwnsGamePassAsync(u25.UserId, u26));

                return;
            end;

            if u29 == Enum.InfoType.Bundle then
                p32(MarketplaceService:PlayerOwnsBundle(u25, u26));

                return;
            end;

            p33("Unsupported info type");
        end);
        v30[u26] = v31;
    end;

    return v31;
end;

if RunContext.IsServer then
    Players.PlayerRemoving:Connect(function(p35: userdata) -- Line: 250, Name: onPlayerRemoving
        -- upvalues: u17 (copy)
        u17[p35] = nil;
    end);
    MarketplaceService.PromptPurchaseFinished:Connect(function(p36: userdata, p37: number, p38: boolean) -- Line: 236, Name: onPromptPurchaseFinished
        -- upvalues: u17 (copy), Promise (copy)
        if not u17[p36] then
            u17[p36] = {};
        end;

        if not u17[p36][Enum.InfoType.Asset] then
            u17[p36][Enum.InfoType.Asset] = {};
        end;

        if p38 then
            u17[p36][Enum.InfoType.Asset][p37] = Promise.resolve(p38);
        end;
    end);
end;

local u39 = {};
local u40 = {};

local function getBoomboxConfigs() -- Line: 276
    -- upvalues: CollectionService (copy)
    local v41 = {};

    for _, v in CollectionService:GetTagged("RelicsBoombox") do
        local v42 = tonumber(v:GetAttribute("Priority")) or 0;
        local Attribute = v:GetAttribute("AccessoryId");
        local Attribute2 = v:GetAttribute("AccessoryType");

        if type(Attribute) == "number" then
            if typeof(Attribute2) == "EnumItem" and Attribute2:IsA("AccessoryType") then
                table.insert(v41, {
                    AssetId = Attribute,
                    AccessoryType = Attribute2,
                    Priority = v42
                });
            else
                table.insert(v41, {
                    AssetId = Attribute,
                    AccessoryType = Enum.AccessoryType.Back,
                    Priority = v42
                });
            end;
        end;
    end;

    table.sort(v41, function(p43, p44) -- Line: 301
        return p43.Priority > p44.Priority;
    end);

    return v41;
end;

local function getAccessory(u45: number, p46: any) -- Line: 308
    -- upvalues: Promise (copy), Players (copy)
    local u47 = p46 or Enum.AccessoryType.Back;

    return Promise.new(function(p48, p49) -- Line: 311
        -- upvalues: u45 (copy), u47 (copy), Players (ref)
        local HumanoidDescription = Instance.new("HumanoidDescription");
        HumanoidDescription:SetAccessories({
            {
                IsLayered = false,
                AssetId = u45,
                AccessoryType = u47
            }
        }, true);
        local v50 = Players:CreateHumanoidModelFromDescription(HumanoidDescription, Enum.HumanoidRigType.R15):FindFirstChildOfClass("Accessory");

        if v50 then
            v50:AddTag("RelicsAccessory");
            p48(v50);
        end;

        p49("Invalid accessory.");
    end);
end;

local function getBoombox(p51: table) -- Line: 332
    -- upvalues: u39 (copy), Promise (copy), getAccessory (copy)
    local AssetId = p51.AssetId;
    local AccessoryType = p51.AccessoryType;

    if not u39[AssetId] then
        u39[AssetId] = Promise.retry(getAccessory, 5, AssetId, AccessoryType);
    end;

    return u39[AssetId];
end;

if RunContext.IsServer then
    local function onMountAdded(u52: userdata) -- Line: 344
        -- upvalues: getBoomboxConfigs (copy), Promise (copy), Players (copy)
        if u52:IsA("Attachment") then
            local v53 = tonumber(u52:GetAttribute("BoomboxId"));
            local v54 = getBoomboxConfigs();
            local v55 = v54[1];

            for _, v in v54 do
                if v.AssetId == v53 then
                    v55 = v;
                    break;
                end;
            end;

            if v55 then
                local AssetId = v55.AssetId;
                local u56 = v55.AccessoryType or Enum.AccessoryType.Back;
                v55 = Promise.new(function(p57, p58) -- Line: 311
                    -- upvalues: AssetId (copy), u56 (copy), Players (ref)
                    local HumanoidDescription = Instance.new("HumanoidDescription");
                    HumanoidDescription:SetAccessories({
                        {
                            IsLayered = false,
                            AssetId = AssetId,
                            AccessoryType = u56
                        }
                    }, true);
                    local v59 = Players:CreateHumanoidModelFromDescription(HumanoidDescription, Enum.HumanoidRigType.R15):FindFirstChildOfClass("Accessory");

                    if v59 then
                        v59:AddTag("RelicsAccessory");
                        p57(v59);
                    end;

                    p58("Invalid accessory.");
                end);
            end;

            if v55 then
                v55:andThen(function(p60: userdata) -- Line: 360
                    -- upvalues: u52 (copy)
                    local v61 = nil;

                    for _, child in p60:GetChildren() do
                        if child:IsA("MeshPart") then
                            v61 = child:Clone();
                            v61.Size = child.MeshSize;
                            v61.CanCollide = false;
                            v61.CanTouch = false;
                            break;
                        end;
                    end;

                    if v61 then
                        local Attachment = Instance.new("Attachment");
                        Attachment.Parent = v61;
                        local RigidConstraint = Instance.new("RigidConstraint");
                        RigidConstraint.Attachment0 = u52;
                        RigidConstraint.Attachment1 = Attachment;
                        RigidConstraint.Parent = u52;
                        v61.Parent = u52;
                        u52.Position = Vector3.new(0, 3 + v61.Size.Y / 2, 0);
                    end;
                end);
            end;
        end;
    end;

    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("RelicsTrialMount");
    Players.PlayerRemoving:Connect(function(p62: userdata) -- Line: 392, Name: onPlayerRemoving
        -- upvalues: u40 (copy)
        u40[p62] = nil;
    end);
    InstanceAddedSignal:Connect(onMountAdded);

    for _, v in CollectionService:GetTagged("RelicsTrialMount") do
        task.spawn(onMountAdded, v);
    end;
end;

local u63 = {};

local function getRolloffCurve() -- Line: 419
    -- upvalues: CollectionService (copy)
    local v64 = CollectionService:GetTagged("RelicsAudioCurve")[1];
    local v65 = 12;
    local v66 = 45;
    local v67 = 4;

    if v64 then
        v65 = tonumber(v64:GetAttribute("MinDistance")) or v65;
        v66 = tonumber(v64:GetAttribute("MaxDistance")) or v66;
        v67 = tonumber(v64:GetAttribute("CurveStep")) or v67;
    end;

    local v68 = {};

    for i = v65, v66, v67 do
        v68[i] = math.pow(i - v65 - (v66 - v65), 2) / math.pow(v66 - v65, 2);
        local _ = i;
    end;

    return v68;
end;

local function createWire(p69, p70) -- Line: 443
    local Wire = Instance.new("Wire");
    Wire.SourceInstance = p69;
    Wire.TargetInstance = p70;
    Wire.Parent = p69;

    return Wire;
end;

local function createServerAudio(p71: userdata) -- Line: 452
    -- upvalues: getRolloffCurve (copy), Trove (copy)
    local v72 = getRolloffCurve();
    local Folder = Instance.new("Folder");
    Folder.Name = "RELICSxyz Boombox";
    Folder.Parent = p71;
    local AudioPlayer = Instance.new("AudioPlayer");
    AudioPlayer.Parent = Folder;
    local AudioFader = Instance.new("AudioFader");
    AudioFader.Parent = Folder;
    local AudioEmitter = Instance.new("AudioEmitter");
    AudioEmitter.AudioInteractionGroup = "RELICSxyz";
    AudioEmitter:SetDistanceAttenuation(v72);
    AudioEmitter.Parent = p71.PrimaryPart;
    local AudioAnalyzer = Instance.new("AudioAnalyzer");
    AudioAnalyzer.SpectrumEnabled = false;
    AudioAnalyzer.Name = "Bass";
    AudioAnalyzer.Parent = Folder;
    local AudioEqualizer = Instance.new("AudioEqualizer");
    AudioEqualizer.MidRange = NumberRange.new(320.78, 1287.02);
    AudioEqualizer.Name = "FilterBass";
    AudioEqualizer.HighGain = -80;
    AudioEqualizer.LowGain = 10;
    AudioEqualizer.MidGain = -80;
    AudioEqualizer.Parent = AudioAnalyzer;
    local AudioAnalyzer2 = Instance.new("AudioAnalyzer");
    AudioAnalyzer2.SpectrumEnabled = false;
    AudioAnalyzer2.Name = "Treble";
    AudioAnalyzer2.Parent = Folder;
    local AudioEqualizer2 = Instance.new("AudioEqualizer");
    AudioEqualizer2.MidRange = NumberRange.new(1000, 4000);
    AudioEqualizer2.Name = "FilterTreble";
    AudioEqualizer2.HighGain = -80;
    AudioEqualizer2.LowGain = -80;
    AudioEqualizer2.MidGain = 10;
    AudioEqualizer2.Parent = AudioAnalyzer2;
    local AudioAnalyzer3 = Instance.new("AudioAnalyzer");
    AudioAnalyzer3.SpectrumEnabled = false;
    AudioAnalyzer3.Name = "Percussion";
    AudioAnalyzer3.Parent = Folder;
    local AudioEqualizer3 = Instance.new("AudioEqualizer");
    AudioEqualizer3.MidRange = NumberRange.new(6000, 20000);
    AudioEqualizer3.Name = "FilterPercussion";
    AudioEqualizer3.HighGain = -80;
    AudioEqualizer3.LowGain = -80;
    AudioEqualizer3.MidGain = 5;
    AudioEqualizer3.Parent = AudioAnalyzer3;
    local v73 = Trove.new();
    v73:Add(AudioEmitter);
    v73:Add(Folder);
    local Wire = Instance.new("Wire");
    Wire.SourceInstance = AudioPlayer;
    Wire.TargetInstance = AudioFader;
    Wire.Parent = AudioPlayer;
    local Wire2 = Instance.new("Wire");
    Wire2.SourceInstance = AudioFader;
    Wire2.TargetInstance = AudioEmitter;
    Wire2.Parent = AudioFader;
    local Wire3 = Instance.new("Wire");
    Wire3.SourceInstance = AudioPlayer;
    Wire3.TargetInstance = AudioEqualizer;
    Wire3.Parent = AudioPlayer;
    local Wire4 = Instance.new("Wire");
    Wire4.SourceInstance = AudioPlayer;
    Wire4.TargetInstance = AudioEqualizer2;
    Wire4.Parent = AudioPlayer;
    local Wire5 = Instance.new("Wire");
    Wire5.SourceInstance = AudioPlayer;
    Wire5.TargetInstance = AudioEqualizer3;
    Wire5.Parent = AudioPlayer;
    local Wire6 = Instance.new("Wire");
    Wire6.SourceInstance = AudioEqualizer;
    Wire6.TargetInstance = AudioAnalyzer;
    Wire6.Parent = AudioEqualizer;
    local Wire7 = Instance.new("Wire");
    Wire7.SourceInstance = AudioEqualizer2;
    Wire7.TargetInstance = AudioAnalyzer2;
    Wire7.Parent = AudioEqualizer2;
    local Wire8 = Instance.new("Wire");
    Wire8.SourceInstance = AudioEqualizer3;
    Wire8.TargetInstance = AudioAnalyzer3;
    Wire8.Parent = AudioEqualizer3;

    return {
        Maid = v73,
        Audio = AudioPlayer,
        Fader = AudioFader
    };
end;

local function getServerAudio(p74: userdata) -- Line: 531
    -- upvalues: u63 (copy), createServerAudio (copy)
    local Character = p74.Character;
    local v75 = u63[p74];

    if Character and not v75 then
        v75 = createServerAudio(Character);
        u63[p74] = v75;
    end;

    return v75;
end;

local u76 = false;
local DataStoreGetOptions = Instance.new("DataStoreGetOptions");
DataStoreGetOptions.UseCache = true;
local u77 = {};
local u78 = {};

local function queueDataSave(p79: number, p80: string) -- Line: 570
    -- upvalues: u77 (copy)
    local v81 = u77[p79];

    if not v81 then
        v81 = {};
        u77[p79] = v81;
    end;

    v81[p80] = true;
end;

local function savePlayerData(u82: number) -- Line: 581
    -- upvalues: u77 (copy), DataStoreService (copy), u78 (copy)
    if u77[u82] then
        local DataStore = DataStoreService:GetDataStore("RELICSxyz", (`{u82}`));
        local v83 = u78[u82];

        if v83 then
            for i, v in u77[u82] do
                local v84 = v83[i];

                if v84 and v then
                    v84:andThen(function(p85) -- Line: 591
                        -- upvalues: DataStore (copy), i (copy), u82 (copy)
                        DataStore:SetAsync(i, p85, { u82 });
                    end);
                end;
            end;
        end;
    end;
end;

function u1.RegisterSecretForUser(u86: number, u87: string, u88: string) -- Line: 637
    -- upvalues: u6 (copy), Players (copy), ContentProvider (copy), u1 (copy)
    if not u6 then
        return false;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(u86);

    if not PlayerByUserId then
        return false;
    end;

    local success = pcall(function() -- Line: 648
        -- upvalues: ContentProvider (ref), u87 (copy), u88 (ref), u6 (ref), u86 (copy)
        ContentProvider:RegisterEncryptedAsset(u87, u88);
        u88 = u6:EncryptStringForPlayerId(u88, u86);
    end);

    if success then
        u1.FireClient(PlayerByUserId, "RegisterSecret", u87, u88);
    end;

    return success;
end;

local function loadEncryptedSongs(p89: table, p90: number) -- Line: 663
    -- upvalues: u1 (copy)
    for _, v in ipairs(p89) do
        if v.secret and (#v.secret == 64 and not u1.RegisterSecretForUser(p90, v.id, v.secret)) then
            warn("[RelicsXYZ] Failed to encrypt asset for song:", v.artist, "-", v.title);
        end;
    end;
end;

if RunContext.IsClient and not RunContext.IsEdit then
    u3.OnClientEvent:Connect(function(p91: string, u92: string, u93: string) -- Line: 678, Name: onRelicsClientEvent
        -- upvalues: ContentProvider (copy)
        if p91 ~= "RegisterSecret" then
            return;
        end;

        if not pcall(function() -- Line: 683
            -- upvalues: ContentProvider (ref), u92 (copy), u93 (copy)
            ContentProvider:RegisterSessionEncryptedAsset(u92, u93);
        end) then
            warn("[RelicsXYZ] Failed to register encrypted asset for song:", u92);
        end;
    end);
end;

local Emotes = script:FindFirstChild("Emotes");
local u94 = {};

local function getEmote(u95: string, u96: number) -- Line: 705
    -- upvalues: Promise (copy), Emotes (ref), InsertService (copy)
    return Promise.new(function(p97, p98) -- Line: 706
        -- upvalues: Emotes (ref), u95 (copy), InsertService (ref), u96 (copy)
        local v99 = Emotes:FindFirstChild(u95);

        if v99 and v99:IsA("Animation") then
            p97(v99);

            return;
        end;

        local v100 = InsertService:LoadAsset(u96):FindFirstChildOfClass("Animation");

        if v100 then
            v100.Name = u95;
            v100.Parent = Emotes;
            v100.Archivable = false;
            v100:ClearAllChildren();
            v100:SetAttribute("AssetId", u96);
            v100:AddTag("RelicsEmote");
            p97(v100);
        end;

        p98("Invalid emote asset.");
    end);
end;

local function loadEmote(p101: string, p102: number) -- Line: 733
    -- upvalues: u94 (copy), Promise (copy), getEmote (copy)
    if not u94[p102] then
        u94[p102] = Promise.retry(getEmote, 5, p101, p102);
    end;

    return u94[p102];
end;

if RunContext.IsServer or RunContext.IsEdit then
    if not Emotes then
        local Folder = Instance.new("Folder");
        Folder.Archivable = false;
        Folder.Name = "Emotes";
        Folder.Parent = script;
        Emotes = Folder;
    end;

    task.spawn(function() -- Line: 750
        -- upvalues: Promise (copy), AvatarEditorService (copy), u94 (copy), getEmote (copy)
        local CatalogSearchParams_new_ret = CatalogSearchParams.new();
        CatalogSearchParams_new_ret.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation };
        CatalogSearchParams_new_ret.SortType = Enum.CatalogSortType.Bestselling;
        CatalogSearchParams_new_ret.SearchKeyword = "dance";
        Promise.retry(function() -- Line: 756
            -- upvalues: Promise (ref), AvatarEditorService (ref), CatalogSearchParams_new_ret (copy)
            return Promise.new(function(p103) -- Line: 757
                -- upvalues: AvatarEditorService (ref), CatalogSearchParams_new_ret (ref)
                p103(AvatarEditorService:SearchCatalog(CatalogSearchParams_new_ret));
            end);
        end, 5):andThen(function(p104: userdata) -- Line: 760
            -- upvalues: u94 (ref), Promise (ref), getEmote (ref)
            while true do
                for _, v in p104:GetCurrentPage() do
                    local Name = v.Name;
                    local Id = v.Id;

                    if not u94[Id] then
                        u94[Id] = Promise.retry(getEmote, 5, Name, Id);
                    end;

                    local _ = u94[Id];
                    task.wait(0.2);
                end;

                if p104.IsFinished then
                    return;
                end;

                p104:AdvanceToNextPageAsync();
            end;
        end);
    end);

    local function onCharacterAdded(p105: userdata) -- Line: 776
        -- upvalues: RunContext (copy), Players (copy), u94 (copy), Promise (copy), getEmote (copy)
        local u106 = nil;

        if RunContext.IsEdit then
            u106 = game:GetService("StudioService"):GetUserId();
        else
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p105);

            if PlayerFromCharacter then
                u106 = PlayerFromCharacter.UserId;
            end;
        end;

        local v107 = p105:FindFirstChildOfClass("Humanoid");

        if v107 then
            v107 = v107:FindFirstChildOfClass("HumanoidDescription");
        end;

        if v107 then
            for i, v in v107:GetEmotes() do
                local v108 = v[1];

                if not u94[v108] then
                    u94[v108] = Promise.retry(getEmote, 5, i, v108);
                end;

                u94[v108]:andThen(function(p109: userdata) -- Line: 797
                    -- upvalues: u106 (ref)
                    p109:SetAttribute(`Owner{tostring(u106):gsub("%-", "_")}`, true);
                end);
                task.wait(0.2);
            end;
        end;
    end;

    local function onPlayerAdded(p110: userdata) -- Line: 807
        -- upvalues: RunContext (copy), Players (copy), onCharacterAdded (copy)
        if RunContext.IsEdit then
            local v111 = Players:CreateHumanoidModelFromUserId(p110.UserId);
            task.spawn(onCharacterAdded, v111);

            return;
        end;

        local Character = p110.Character;
        p110.CharacterAdded:Connect(onCharacterAdded);

        if Character and Character.Parent then
            task.spawn(onCharacterAdded, Character);
        end;
    end;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        task.spawn(function() -- Line: 825
            -- upvalues: Players (copy), UserId (copy), onCharacterAdded (copy)
            onCharacterAdded((Players:CreateHumanoidModelFromUserId(UserId)));
        end);
    else
        for _, v in Players:GetPlayers() do
            task.spawn(onPlayerAdded, v);
        end;

        Players.PlayerAdded:Connect(onPlayerAdded);
    end;
end;

local u112 = {};

local function getSkinImpl(p113: number) -- Line: 851
    -- upvalues: DataStoreService (copy), u78 (copy), Promise (copy), DataStoreGetOptions (copy)
    local DataStore = DataStoreService:GetDataStore("RELICSxyz", (`{p113}`));
    local v114 = u78[p113];

    if not v114 then
        v114 = {};
        u78[p113] = v114;
    end;

    local UGCSkin = v114.UGCSkin;

    if not UGCSkin then
        UGCSkin = Promise.new(function(p115, p116) -- Line: 863
            -- upvalues: DataStore (copy), DataStoreGetOptions (ref)
            p115(DataStore:GetAsync("UGCSkin", DataStoreGetOptions) or {});
        end);
        v114.UGCSkin = UGCSkin;
    end;

    return assert(UGCSkin);
end;

local function equipSkinImpl(u117: userdata, u118: string?) -- Line: 874
    -- upvalues: u112 (copy), getSkinImpl (copy), u40 (copy), u77 (copy)
    local u119;

    if u118 then
        u119 = u112[u118];
    else
        u119 = u118;
    end;

    getSkinImpl(u117.UserId):andThen(function(p120) -- Line: 877
        -- upvalues: u40 (ref), u117 (copy), u119 (copy), u118 (copy), u77 (ref)
        local v121 = u40[u117];

        if v121 then
            v121 = v121:FindFirstChild("Handle");
        end;

        if v121 and v121:IsA("MeshPart") then
            if u119 then
                local TextureID = v121.TextureID;

                if not v121:GetAttribute("DefaultSkin") then
                    v121:SetAttribute("DefaultSkin", TextureID);
                end;

                v121.TextureID = `rbxassetid://{u119.TextureId}`;
            else
                local Attribute = v121:GetAttribute("DefaultSkin");

                if type(Attribute) == "string" then
                    v121.TextureID = Attribute;
                else
                    v121:SetAttribute("DefaultSkin", v121.TextureID);
                end;
            end;
        end;

        if p120.Skin ~= u118 then
            p120.Skin = u118;
            local UserId = u117.UserId;
            local v122 = u77[UserId];

            if not v122 then
                v122 = {};
                u77[UserId] = v122;
            end;

            v122.UGCSkin = true;
        end;
    end);
end;

if RunContext.IsServer then
    local function onPlayerRemoving(p123: userdata) -- Line: 909
        -- upvalues: u76 (ref), u78 (copy)
        if not u76 then
            u78[p123.UserId] = nil;
        end;
    end;

    local function onSkinAdded(p124: userdata) -- Line: 915
        -- upvalues: u112 (copy)
        local Attribute = p124:GetAttribute("ItemId");
        local Attribute2 = p124:GetAttribute("ItemType");
        local Attribute3 = p124:GetAttribute("TextureId");
        local Attribute4 = p124:GetAttribute("LegacyId");

        if type(Attribute) ~= "number" then
            warn("[RelicsXYZ] Invalid skin item ID.", p124);

            return;
        end;

        if type(Attribute3) ~= "number" then
            warn("[RelicsXYZ] Invalid skin texture ID.", p124);

            return;
        end;

        if Attribute4 and type(Attribute4) ~= "number" then
            warn("[RelicsXYZ] Invalid skin legacy ID.", p124);

            return;
        end;

        if typeof(Attribute2) == "EnumItem" and Attribute2:IsA("InfoType") then
            u112[p124.Name] = {
                ItemId = Attribute,
                TextureId = Attribute3,
                LegacyId = Attribute4,
                ItemType = Attribute2
            };

            return;
        end;

        warn("[RelicsXYZ] Invalid skin item type.", p124);
        u112[p124.Name] = {
            ItemId = Attribute,
            TextureId = Attribute3,
            LegacyId = Attribute4,
            ItemType = Enum.InfoType.Asset
        };
    end;

    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("RelicsUGCSkin");
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("RelicsUGCSkin");
    InstanceAddedSignal:Connect(onSkinAdded);
    InstanceRemovedSignal:Connect(function(p125: userdata) -- Line: 955, Name: onSkinRemoved
        -- upvalues: u112 (copy)
        u112[p125.Name] = nil;
    end);
    Players.PlayerRemoving:Connect(onPlayerRemoving);

    for _, v in CollectionService:GetTagged("RelicsUGCSkin") do
        onSkinAdded(v);
    end;
end;

local u126 = {};

local function getFavoritesImpl(p127: number) -- Line: 979
    -- upvalues: DataStoreService (copy), u78 (copy), Promise (copy), DataStoreGetOptions (copy)
    local DataStore = DataStoreService:GetDataStore("RELICSxyz", (`{p127}`));
    local v128 = u78[p127];

    if not v128 then
        v128 = {};
        u78[p127] = v128;
    end;

    local Favorites = v128.Favorites;

    if not Favorites then
        Favorites = Promise.new(function(p129) -- Line: 991
            -- upvalues: DataStore (copy), DataStoreGetOptions (ref)
            local Async = DataStore:GetAsync("Favorites", DataStoreGetOptions);

            if type(Async) == "table" and #Async > 0 then
                p129(Async);
            end;

            p129({});
        end);
        v128.Favorites = Favorites;
    end;

    return assert(Favorites);
end;

function u1.GetFavoritesAsync() -- Line: 1007
    -- upvalues: RunContext (copy), getFavoritesImpl (copy), Promise (copy), u1 (copy), u126 (ref)
    local v130;

    if RunContext.IsEdit then
        v130 = getFavoritesImpl((game:GetService("StudioService"):GetUserId()));
    else
        v130 = Promise.new(function(p131, p132) -- Line: 1015
            -- upvalues: u1 (ref)
            local v133, v134 = u1.InvokeServer("GetFavorites");

            if v133 then
                p131(v134);

                return;
            end;

            p132(v134);
        end);
    end;

    v130:andThen(function(p135) -- Line: 1026
        -- upvalues: u126 (ref)
        u126 = p135;
    end);

    return v130;
end;

function u1.GetCachedFavorites() -- Line: 1033
    -- upvalues: u126 (ref)
    return u126;
end;

local function addFavoriteImpl(u136: number, u137: string) -- Line: 1041
    -- upvalues: getFavoritesImpl (copy), u77 (copy), Promise (copy)
    return getFavoritesImpl(u136):andThen(function(p138) -- Line: 1042
        -- upvalues: u137 (copy), u136 (copy), u77 (ref), Promise (ref)
        if table.find(p138, u137) then
            return Promise.reject("Song already favorited!");
        end;

        local v139 = u136;
        local v140 = u77[v139];

        if not v140 then
            v140 = {};
            u77[v139] = v140;
        end;

        v140.Favorites = true;
        table.insert(p138, 1, u137);

        return u137;
    end);
end;

function u1.AddFavoriteAsync(u141: string) -- Line: 1053
    -- upvalues: RunContext (copy), getFavoritesImpl (copy), u77 (copy), Promise (copy), savePlayerData (copy), u1 (copy)
    local v142, v143;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        v142, v143 = getFavoritesImpl(UserId):andThen(function(p144) -- Line: 1042
            -- upvalues: u141 (copy), UserId (copy), u77 (ref), Promise (ref)
            if table.find(p144, u141) then
                return Promise.reject("Song already favorited!");
            end;

            local v145 = UserId;
            local v146 = u77[v145];

            if not v146 then
                v146 = {};
                u77[v145] = v146;
            end;

            v146.Favorites = true;
            table.insert(p144, 1, u141);

            return u141;
        end):await();
        task.spawn(savePlayerData, UserId);
    else
        v142, v143 = u1.InvokeServer("AddFavorite", u141);
    end;

    if v142 then
        u1.FavoriteAdded:Fire(v143);
    end;

    return v142, v143;
end;

local function removeFavoriteImpl(u147: number, u148: string) -- Line: 1079
    -- upvalues: getFavoritesImpl (copy), u77 (copy), Promise (copy)
    return getFavoritesImpl(u147):andThen(function(p149) -- Line: 1080
        -- upvalues: u148 (copy), u147 (copy), u77 (ref), Promise (ref)
        local table_find_ret = table.find(p149, u148);

        if not table_find_ret then
            return Promise.reject("Song wasn\'t favorited!");
        end;

        table.remove(p149, table_find_ret);
        local v150 = u147;
        local v151 = u77[v150];

        if not v151 then
            v151 = {};
            u77[v150] = v151;
        end;

        v151.Favorites = true;

        return u148;
    end);
end;

function u1.RemoveFavoriteAsync(u152: string) -- Line: 1093
    -- upvalues: RunContext (copy), getFavoritesImpl (copy), u77 (copy), Promise (copy), savePlayerData (copy), u1 (copy)
    local v153, v154;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        v153, v154 = getFavoritesImpl(UserId):andThen(function(p155) -- Line: 1080
            -- upvalues: u152 (copy), UserId (copy), u77 (ref), Promise (ref)
            local table_find_ret = table.find(p155, u152);

            if not table_find_ret then
                return Promise.reject("Song wasn\'t favorited!");
            end;

            table.remove(p155, table_find_ret);
            local v156 = UserId;
            local v157 = u77[v156];

            if not v157 then
                v157 = {};
                u77[v156] = v157;
            end;

            v157.Favorites = true;

            return u152;
        end):await();
        task.spawn(savePlayerData, UserId);
    else
        v153, v154 = u1.InvokeServer("RemoveFavorite", u152);
    end;

    if v153 then
        u1.FavoriteRemoved:Fire(v154);
    end;

    return v153, v154;
end;

local u158 = {};

local function getSettingsImpl(p159: number) -- Line: 1123
    -- upvalues: DataStoreService (copy), u78 (copy), Promise (copy), DataStoreGetOptions (copy), Settings (copy)
    local DataStore = DataStoreService:GetDataStore("RELICSxyz", (`{p159}`));
    local v160 = u78[p159];

    if not v160 then
        v160 = {};
        u78[p159] = v160;
    end;

    local Settings2 = v160.Settings;

    if not Settings2 then
        Settings2 = Promise.new(function(p161) -- Line: 1135
            -- upvalues: DataStore (copy), DataStoreGetOptions (ref), Settings (ref)
            local Async = DataStore:GetAsync("Settings", DataStoreGetOptions);
            local v162 = type(Async) ~= "table" and {} or Async;

            for i, v in pairs(Settings) do
                local Default = v.Default;

                if typeof(v162[i]) ~= typeof(Default) then
                    v162[i] = v.Default;
                end;
            end;

            p161(v162);
        end);
        v160.Settings = Settings2;
    end;

    return assert(Settings2);
end;

function u1.GetSettingsAsync() -- Line: 1160
    -- upvalues: RunContext (copy), getSettingsImpl (copy), u1 (copy), u158 (ref), Settings (copy)
    local v163, v164;

    if RunContext.IsEdit then
        v163, v164 = getSettingsImpl((game:GetService("StudioService"):GetUserId())):await();
    else
        v163, v164 = u1.InvokeServer("GetSettings");
    end;

    if v163 then
        u158 = v164;

        return v164;
    end;

    local v165 = {};

    for i, v in pairs(Settings) do
        v165[i] = v.Default;
    end;

    return v165;
end;

function u1.GetCachedSettings() -- Line: 1187
    -- upvalues: u158 (ref)
    return u158;
end;

local u166 = Signal.new();

local function changeSettingImpl(u167: number, u168: string, u169: boolean) -- Line: 1197
    -- upvalues: getSettingsImpl (copy), Promise (copy), u77 (copy), u166 (copy)
    return getSettingsImpl(u167):andThen(function(p170) -- Line: 1198
        -- upvalues: u168 (copy), Promise (ref), u169 (copy), u167 (copy), u77 (ref), u166 (ref)
        if p170[u168] == nil then
            return Promise.reject("Invalid setting key.");
        end;

        p170[u168] = u169;
        local v171 = u167;
        local v172 = u77[v171];

        if not v172 then
            v172 = {};
            u77[v171] = v172;
        end;

        v172.Settings = true;
        u166:Fire(u167, u168, u169);

        return p170;
    end);
end;

function u1.ChangeSettingAsync(u173: string, u174: boolean) -- Line: 1211
    -- upvalues: RunContext (copy), getSettingsImpl (copy), Promise (copy), u77 (copy), u166 (copy), savePlayerData (copy), u2 (ref), u1 (copy)
    local v175;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        v175 = getSettingsImpl(UserId):andThen(function(p176) -- Line: 1198
            -- upvalues: u173 (copy), Promise (ref), u174 (copy), UserId (copy), u77 (ref), u166 (ref)
            if p176[u173] == nil then
                return Promise.reject("Invalid setting key.");
            end;

            p176[u173] = u174;
            local v177 = UserId;
            local v178 = u77[v177];

            if not v178 then
                v178 = {};
                u77[v177] = v178;
            end;

            v178.Settings = true;
            u166:Fire(UserId, u173, u174);

            return p176;
        end):await();
        task.spawn(savePlayerData, UserId);
    else
        v175 = u2:InvokeServer("ChangeSetting", u173, u174);
    end;

    if v175 then
        u1.SettingChanged:Fire(u173, u174);
    end;

    return v175;
end;

local u179 = {
    Rolls = 0,
    LastRenew = 0,
    Unlocks = {}
};
local u180 = {};

local function getAurasMetadata() -- Line: 1274
    -- upvalues: CollectionService (copy)
    local v181 = CollectionService:GetTagged("RelicsAurasMetadata")[1];

    if not v181 then
        return {
            RollsPerDay = 5,
            RollsWithGamePass = 25
        };
    end;

    local Attributes = v181:GetAttributes();

    return {
        RollGamePass = tonumber(Attributes.RollGamePass),
        RollsPerDay = tonumber(Attributes.RollsPerDay) or 5,
        RollsWithGamePass = tonumber(Attributes.RollsWithGamePass) or 25
    };
end;

local function getAuraDataImpl(p182: number) -- Line: 1293
    -- upvalues: DataStoreService (copy), u78 (copy), Promise (copy), DataStoreGetOptions (copy)
    local DataStore = DataStoreService:GetDataStore("RELICSxyz", (`{p182}`));
    local v183 = u78[p182];

    if not v183 then
        v183 = {};
        u78[p182] = v183;
    end;

    local Auras = v183.Auras;

    if not Auras then
        Auras = Promise.new(function(p184, p185) -- Line: 1305
            -- upvalues: DataStore (copy), DataStoreGetOptions (ref)
            p184(DataStore:GetAsync("Auras", DataStoreGetOptions) or {});
        end);
        v183.Auras = Auras;
    end;

    return assert(Auras);
end;

local function getMaxRolls(p186: number) -- Line: 1316
    -- upvalues: getAurasMetadata (copy), CollectionService (copy), Players (copy), getOwnership (copy)
    local v187 = getAurasMetadata();
    local RollGamePass = v187.RollGamePass;
    local RollsPerDay = v187.RollsPerDay;
    local v188 = true;
    local v189 = CollectionService:GetTagged("RelicsFeatures")[1];

    if v189 then
        v189 = v189:GetAttribute("Demo");
    end;

    if v189 and true or false then
        return 999, v188;
    end;

    if RollGamePass then
        local PlayerByUserId = Players:GetPlayerByUserId(p186);

        if PlayerByUserId then
            PlayerByUserId = getOwnership(PlayerByUserId, RollGamePass, Enum.InfoType.GamePass);
        end;

        if PlayerByUserId then
            local v190, v191 = PlayerByUserId:await();

            if v190 then
                if v191 then
                    return v187.RollsWithGamePass, v188;
                end;
            else
                v188 = false;
            end;
        end;
    end;

    return RollsPerDay, v188;
end;

local function getAuraSnapshotImpl(u192: number) -- Line: 1345
    -- upvalues: getAuraDataImpl (copy), getMaxRolls (copy), Players (copy), u77 (copy), u1 (copy)
    return getAuraDataImpl(u192):andThen(function(p193) -- Line: 1346
        -- upvalues: getMaxRolls (ref), u192 (copy), Players (ref), u77 (ref), u1 (ref)
        local v194 = p193.LastRenew or 0;
        local os_time_ret = os.time();

        if os_time_ret - v194 > 86400 then
            local v195, v196 = getMaxRolls(u192);

            if v196 then
                local PlayerByUserId = Players:GetPlayerByUserId(u192);
                p193.Rolls = v195;
                p193.LastRenew = os_time_ret;
                local v197 = u192;
                local v198 = u77[v197];

                if not v198 then
                    v198 = {};
                    u77[v197] = v198;
                end;

                v198.Auras = true;

                if PlayerByUserId then
                    u1.FireClient(PlayerByUserId, "SyncAuraData");
                end;
            end;
        end;

        return {
            Rolls = p193.Rolls or 0,
            LastRenew = p193.LastRenew or 0,
            Unlocks = p193.Unlocks or {},
            Aura = p193.Aura
        };
    end);
end;

local function rollAura(u199: number) -- Line: 1374
    -- upvalues: getAuraDataImpl (copy), RunContext (copy), u77 (copy), u180 (copy), Players (copy), u1 (copy)
    return getAuraDataImpl(u199):andThen(function(p200) -- Line: 1375
        -- upvalues: RunContext (ref), u199 (copy), u77 (ref), u180 (ref), Players (ref), u1 (ref)
        local v201 = p200.Rolls or 0;

        if v201 <= 0 then
            return {
                Rolled = false
            };
        end;

        local math_random_ret = math.random();

        if not RunContext.IsStudio then
            p200.Rolls = math.max(0, v201 - 1);
        end;

        local v202 = u199;
        local v203 = u77[v202];

        if not v203 then
            v203 = {};
            u77[v202] = v203;
        end;

        v203.Auras = true;

        if math_random_ret < 0.05 then
            local v204 = {};
            local v205 = 0;

            for i, v in pairs(u180) do
                local Chance = v.Chance;

                if Chance > 0 then
                    table.insert(v204, {
                        Name = i,
                        Weight = Chance
                    });
                    v205 = v205 + Chance;
                end;
            end;

            local v206 = math.random() * v205;
            local v207 = 0;

            for _, v in ipairs(v204) do
                local v208 = v207 + v.Weight;

                if v207 <= v206 and v206 <= v208 then
                    local PlayerByUserId = Players:GetPlayerByUserId(u199);
                    local Name = v.Name;

                    if not p200.Unlocks then
                        p200.Unlocks = {};
                    end;

                    p200.Unlocks[Name] = true;
                    local v209 = u199;
                    local v210 = u77[v209];

                    if not v210 then
                        v210 = {};
                        u77[v209] = v210;
                    end;

                    v210.Auras = true;

                    if PlayerByUserId then
                        u1.FireClient(PlayerByUserId, "SyncAuraData");
                    end;

                    return {
                        Rolled = true,
                        Roll = math_random_ret,
                        UnlockedAura = Name
                    };
                end;

                v207 = v208;
            end;
        end;

        return {
            Rolled = true,
            Roll = math_random_ret
        };
    end);
end;

local function equipAuraImpl(u211: userdata, u212: string?, u213: boolean?) -- Line: 1448
    -- upvalues: u180 (copy), getAuraDataImpl (copy), CollectionService (copy), getOwnership (copy), u40 (copy), u77 (copy), u1 (copy)
    local u214 = u212 and u180[u212];
    getAuraDataImpl(u211.UserId):andThen(function(p215) -- Line: 1451
        -- upvalues: u214 (copy), u212 (ref), CollectionService (ref), getOwnership (ref), u211 (copy), u213 (copy), u40 (ref), u77 (ref), u1 (ref)
        if u214 and not (p215.Unlocks or {})[u212] then
            local GamePass = u214.GamePass;
            local v216 = CollectionService:GetTagged("RelicsFeatures")[1];

            if v216 then
                v216 = v216:GetAttribute("Demo");
            end;

            local v217 = v216 and true or false;

            if GamePass then
                local v218, v219 = getOwnership(u211, GamePass, Enum.InfoType.GamePass):await();
                v217 = v218 and v219 and true or v217;
            end;

            if not v217 then
                warn("Aura", u212, "is not unlocked.");

                return;
            end;
        end;

        if p215.Aura == u212 and not u213 then
            warn("Already equipped!");

            return;
        end;

        local v220 = u40[u211];

        if v220 then
            v220 = v220:FindFirstChild("Handle");
        end;

        local v221;

        if v220 then
            local Aura = v220:FindFirstChild("Aura");

            if Aura then
                Aura:Destroy();
            end;

            v221 = v220:FindFirstChildOfClass("Attachment");
        else
            v221 = nil;
        end;

        if u214 and u214.Effect:IsA("BasePart") then
            local v222 = u214.Effect:Clone();
            v222.Name = "Aura";
            local Attachment = Instance.new("Attachment");
            Attachment.Name = "AuraMount";
            Attachment.Parent = v222;
            local RigidConstraint = Instance.new("RigidConstraint");
            RigidConstraint.Attachment0 = v221;
            RigidConstraint.Attachment1 = Attachment;
            RigidConstraint.Parent = Attachment;

            for _, child in v222:GetChildren() do
                if child:IsA("Attachment") then
                    child:AddTag("RelicsAuraAtt");
                    local Name = child.Name;

                    if child:IsA("Bone") then
                        child:SetAttribute("Class", Name);
                        child:AddTag("RelicsAuraFx");
                    end;

                    for _, descendant in child:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Bone"))) then
                            descendant:SetAttribute("Class", Name);
                            descendant:AddTag("RelicsAuraFx");
                        elseif descendant:IsA("BasePart") then
                            descendant.Massless = true;
                        end;
                    end;
                else
                    child:Destroy();
                end;
            end;

            v222.Transparency = 1;
            v222.CanCollide = false;
            v222.CanQuery = false;
            v222.CanTouch = false;
            v222.Anchored = false;
            v222.Massless = true;
            v222.Parent = v220;
        else
            u212 = nil;
        end;

        p215.Aura = u212;
        local UserId = u211.UserId;
        local v223 = u77[UserId];

        if not v223 then
            v223 = {};
            u77[UserId] = v223;
        end;

        v223.Auras = true;
        u1.FireClient(u211, "SyncAuraData");
    end);
end;

if RunContext.IsServer or RunContext.IsEdit then
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("RelicsAura");
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("RelicsAura");

    local function onAuraAdded(p224: userdata) -- Line: 1556
        -- upvalues: u180 (copy)
        local Aura = p224:FindFirstChild("Aura");
        local v225 = tonumber(p224:GetAttribute("Chance")) or 0;
        local v226 = tonumber(p224:GetAttribute("GamePass"));

        if Aura then
            u180[p224.Name] = {
                Effect = Aura,
                Chance = v225,
                GamePass = v226
            };

            return;
        end;

        warn("[RelicsXYZ] Invalid aura effect.", p224);
    end;

    InstanceAddedSignal:Connect(onAuraAdded);
    InstanceRemovedSignal:Connect(function(p227: userdata) -- Line: 1573, Name: onAuraRemoved
        -- upvalues: u180 (copy)
        u180[p227.Name] = nil;
    end);

    for _, v in CollectionService:GetTagged("RelicsAura") do
        onAuraAdded(v);
    end;

    for _, v in CollectionService:GetTagged("RelicsDebugResetRolls") do
        if v:IsA("ClickDetector") then
            v.MouseClick:Connect(function(u228) -- Line: 1589
                -- upvalues: getAuraDataImpl (copy), getMaxRolls (copy), u77 (copy), u1 (copy)
                getAuraDataImpl(u228.UserId):andThen(function(p229) -- Line: 1590
                    -- upvalues: getMaxRolls (ref), u228 (copy), u77 (ref), u1 (ref)
                    local v230, v231 = getMaxRolls(u228.UserId);

                    if v231 then
                        p229.Rolls = v230;
                        p229.LastRenew = os.time();
                        local UserId = u228.UserId;
                        local v232 = u77[UserId];

                        if not v232 then
                            v232 = {};
                            u77[UserId] = v232;
                        end;

                        v232.Auras = true;
                        u1.FireClient(u228, "SyncAuraData");
                    end;
                end);
            end);
        end;
    end;
end;

function u1.GetAuraDataAsync() -- Line: 1605
    -- upvalues: RunContext (copy), getAuraDataImpl (copy), getMaxRolls (copy), Players (copy), u77 (copy), u1 (copy), Promise (copy), u2 (ref), u179 (ref)
    local v233;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        v233 = getAuraDataImpl(UserId):andThen(function(p234) -- Line: 1346
            -- upvalues: getMaxRolls (ref), UserId (copy), Players (ref), u77 (ref), u1 (ref)
            local v235 = p234.LastRenew or 0;
            local os_time_ret = os.time();

            if os_time_ret - v235 > 86400 then
                local v236, v237 = getMaxRolls(UserId);

                if v237 then
                    local PlayerByUserId = Players:GetPlayerByUserId(UserId);
                    p234.Rolls = v236;
                    p234.LastRenew = os_time_ret;
                    local v238 = UserId;
                    local v239 = u77[v238];

                    if not v239 then
                        v239 = {};
                        u77[v238] = v239;
                    end;

                    v239.Auras = true;

                    if PlayerByUserId then
                        u1.FireClient(PlayerByUserId, "SyncAuraData");
                    end;
                end;
            end;

            return {
                Rolls = p234.Rolls or 0,
                LastRenew = p234.LastRenew or 0,
                Unlocks = p234.Unlocks or {},
                Aura = p234.Aura
            };
        end);
    else
        v233 = Promise.new(function(p240, p241) -- Line: 1613
            -- upvalues: u2 (ref)
            local v242, v243 = u2:InvokeServer("GetAuraData");

            if v242 then
                p240(v243);

                return;
            end;

            p241(v243);
        end);
    end;

    v233:andThen(function(p244) -- Line: 1624
        -- upvalues: u179 (ref), u1 (ref)
        u179 = p244;
        u1.AuraUpdated:Fire(p244);
    end);

    return v233;
end;

function u1.GetCachedAuraData() -- Line: 1632
    -- upvalues: u179 (ref)
    return u179;
end;

function u1.RollForAura() -- Line: 1636
    -- upvalues: RunContext (copy), getAuraDataImpl (copy), u77 (copy), u180 (copy), Players (copy), u1 (copy), savePlayerData (copy)
    local v245, v246;

    if RunContext.IsEdit then
        local UserId = game:GetService("StudioService"):GetUserId();
        v245, v246 = getAuraDataImpl(UserId):andThen(function(p247) -- Line: 1375
            -- upvalues: RunContext (ref), UserId (copy), u77 (ref), u180 (ref), Players (ref), u1 (ref)
            local v248 = p247.Rolls or 0;

            if v248 <= 0 then
                return {
                    Rolled = false
                };
            end;

            local math_random_ret = math.random();

            if not RunContext.IsStudio then
                p247.Rolls = math.max(0, v248 - 1);
            end;

            local v249 = UserId;
            local v250 = u77[v249];

            if not v250 then
                v250 = {};
                u77[v249] = v250;
            end;

            v250.Auras = true;

            if math_random_ret < 0.05 then
                local v251 = {};
                local v252 = 0;

                for i, v in pairs(u180) do
                    local Chance = v.Chance;

                    if Chance > 0 then
                        table.insert(v251, {
                            Name = i,
                            Weight = Chance
                        });
                        v252 = v252 + Chance;
                    end;
                end;

                local v253 = math.random() * v252;
                local v254 = 0;

                for _, v in ipairs(v251) do
                    local v255 = v254 + v.Weight;

                    if v254 <= v253 and v253 <= v255 then
                        local PlayerByUserId = Players:GetPlayerByUserId(UserId);
                        local Name = v.Name;

                        if not p247.Unlocks then
                            p247.Unlocks = {};
                        end;

                        p247.Unlocks[Name] = true;
                        local v256 = UserId;
                        local v257 = u77[v256];

                        if not v257 then
                            v257 = {};
                            u77[v256] = v257;
                        end;

                        v257.Auras = true;

                        if PlayerByUserId then
                            u1.FireClient(PlayerByUserId, "SyncAuraData");
                        end;

                        return {
                            Rolled = true,
                            Roll = math_random_ret,
                            UnlockedAura = Name
                        };
                    end;

                    v254 = v255;
                end;
            end;

            return {
                Rolled = true,
                Roll = math_random_ret
            };
        end):await();
        task.spawn(savePlayerData, UserId);
    else
        v245, v246 = u1.InvokeServer("RollForAura");
    end;

    if v245 then
        u1.GetAuraDataAsync():andThen(function(p258: table) -- Line: 1654
            -- upvalues: u1 (ref)
            local table_clone_ret = table.clone(p258);
            u1.AuraUpdated:Fire(table_clone_ret);
        end);
        u1.AuraRolled:Fire(v246);
    end;

    return v245, v246;
end;

if RunContext.IsServer then
    local v259 = getAurasMetadata();
    local RollGamePass = v259.RollGamePass;

    if RollGamePass then
        local u260 = v259.RollsWithGamePass - v259.RollsPerDay;
        MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(u261: userdata, p262: number, p263: boolean) -- Line: 1674, Name: onGamePassPurchased
            -- upvalues: RollGamePass (copy), getAuraDataImpl (copy), u260 (copy), u77 (copy), u1 (copy)
            if p262 ~= RollGamePass or not p263 then
                return;
            end;

            getAuraDataImpl(u261.UserId):andThen(function(p264) -- Line: 1679
                -- upvalues: u260 (ref), u261 (copy), u77 (ref), u1 (ref)
                local v265 = (tonumber(p264.Rolls) or 0) + u260;
                p264.Rolls = math.max(0, v265);
                local UserId = u261.UserId;
                local v266 = u77[UserId];

                if not v266 then
                    v266 = {};
                    u77[UserId] = v266;
                end;

                v266.Auras = true;
                u1.FireClient(u261, "SyncAuraData");
            end);
        end);
    end;
end;

local u267 = nil;
local u268 = {};

local function u316(u269: userdata) -- Line: 1702
    -- upvalues: Players (copy), u268 (copy), Trove (copy), getBoomboxConfigs (copy), getOwnership (copy), u39 (copy), Promise (copy), getAccessory (copy), u40 (copy), getSkinImpl (copy), u112 (copy), u77 (copy), getAuraDataImpl (copy), u180 (copy), CollectionService (copy), u1 (copy), getSettingsImpl (copy), u63 (copy), MarketplaceService (copy), createServerAudio (copy), u166 (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u269);

    if not PlayerFromCharacter then
        return;
    end;

    local v270 = u268[PlayerFromCharacter] or Trove.new();
    local UserId = PlayerFromCharacter.UserId;
    local u271 = nil;
    u268[PlayerFromCharacter] = v270;
    v270:Clean();

    local function onSettingChanged(p272, p273, u274) -- Line: 1718
        -- upvalues: PlayerFromCharacter (copy), getBoomboxConfigs (ref), u269 (copy), getOwnership (ref), u39 (ref), Promise (ref), getAccessory (ref), u271 (ref), u40 (ref), getSkinImpl (ref), UserId (copy), u112 (ref), u77 (ref), getAuraDataImpl (ref), u180 (ref), CollectionService (ref), u1 (ref)
        if p272 ~= PlayerFromCharacter.UserId then
            return;
        end;

        if p273 ~= "BoomboxIdol" then
            return;
        end;

        local v275 = getBoomboxConfigs();
        local u276 = u269:FindFirstChildOfClass("Humanoid");

        if not (u276 and next(v275)) then
            return;
        end;

        local v277 = v275[1];
        local u278 = {};

        for _, v in ipairs(v275) do
            local v279 = getOwnership(PlayerFromCharacter, v.AssetId);
            table.insert(u278, v279);
        end;

        local AssetId = v277.AssetId;
        local AccessoryType = v277.AccessoryType;

        if not u39[AssetId] then
            u39[AssetId] = Promise.retry(getAccessory, 5, AssetId, AccessoryType);
        end;

        local u280 = u39[AssetId];
        local u281 = Promise.allSettled(u278);

        if u271 then
            task.cancel(u271);
        end;

        u271 = task.spawn(function() -- Line: 1749
            -- upvalues: u280 (copy), u281 (copy), u278 (copy), u274 (copy), u269 (ref), u40 (ref), PlayerFromCharacter (ref), u276 (copy), getSkinImpl (ref), UserId (ref), u112 (ref), u77 (ref), getAuraDataImpl (ref), u180 (ref), CollectionService (ref), getOwnership (ref), u1 (ref)
            local v282, v283 = u280:await();

            if not (v282 and v283) then
                return;
            end;

            local v284 = false;

            if not u281:await() then
                return;
            end;

            for _, v in u278 do
                local v285, v286 = v:await();

                if v285 and v286 then
                    v284 = true;
                    break;
                end;
            end;

            if not v284 then
                return;
            end;

            local Name = v283.Name;

            if not u274 then
                local v287 = u269:FindFirstChild(Name);

                if v287 then
                    v287:Destroy();
                end;

                u40[PlayerFromCharacter] = nil;

                return;
            end;

            local v288 = u269:FindFirstChild(Name);

            if v288 and v288:IsA("Accessory") then
                u40[PlayerFromCharacter] = v288;
            else
                local v289 = v283:Clone();
                u276:AddAccessory(v289);

                for _, child in v289:GetChildren() do
                    if child:IsA("MeshPart") then
                        child.CanCollide = false;
                        child.CanQuery = false;
                        child.CanTouch = false;
                        break;
                    end;
                end;

                u40[PlayerFromCharacter] = v289;
            end;

            getSkinImpl(UserId):andThen(function(p290) -- Line: 1799
                -- upvalues: PlayerFromCharacter (ref), u112 (ref), getSkinImpl (ref), u40 (ref), u77 (ref)
                local u291 = PlayerFromCharacter;
                local Skin = p290.Skin;
                local u292;

                if Skin then
                    u292 = u112[Skin];
                else
                    u292 = Skin;
                end;

                getSkinImpl(u291.UserId):andThen(function(p293) -- Line: 877
                    -- upvalues: u40 (ref), u291 (copy), u292 (copy), Skin (copy), u77 (ref)
                    local v294 = u40[u291];

                    if v294 then
                        v294 = v294:FindFirstChild("Handle");
                    end;

                    if v294 and v294:IsA("MeshPart") then
                        if u292 then
                            local TextureID = v294.TextureID;

                            if not v294:GetAttribute("DefaultSkin") then
                                v294:SetAttribute("DefaultSkin", TextureID);
                            end;

                            v294.TextureID = `rbxassetid://{u292.TextureId}`;
                        else
                            local Attribute = v294:GetAttribute("DefaultSkin");

                            if type(Attribute) == "string" then
                                v294.TextureID = Attribute;
                            else
                                v294:SetAttribute("DefaultSkin", v294.TextureID);
                            end;
                        end;
                    end;

                    if p293.Skin ~= Skin then
                        p293.Skin = Skin;
                        local UserId2 = u291.UserId;
                        local v295 = u77[UserId2];

                        if not v295 then
                            v295 = {};
                            u77[UserId2] = v295;
                        end;

                        v295.UGCSkin = true;
                    end;
                end);
            end);
            getAuraDataImpl(UserId):andThen(function(p296) -- Line: 1803
                -- upvalues: PlayerFromCharacter (ref), u180 (ref), getAuraDataImpl (ref), CollectionService (ref), getOwnership (ref), u40 (ref), u77 (ref), u1 (ref)
                local u297 = PlayerFromCharacter;
                local Aura = p296.Aura;
                local u298 = Aura and u180[Aura];
                local u299 = true;
                getAuraDataImpl(u297.UserId):andThen(function(p300) -- Line: 1451
                    -- upvalues: u298 (copy), Aura (ref), CollectionService (ref), getOwnership (ref), u297 (copy), u299 (copy), u40 (ref), u77 (ref), u1 (ref)
                    if u298 and not (p300.Unlocks or {})[Aura] then
                        local GamePass = u298.GamePass;
                        local v301 = CollectionService:GetTagged("RelicsFeatures")[1];

                        if v301 then
                            v301 = v301:GetAttribute("Demo");
                        end;

                        local v302 = v301 and true or false;

                        if GamePass then
                            local v303, v304 = getOwnership(u297, GamePass, Enum.InfoType.GamePass):await();
                            v302 = v303 and v304 and true or v302;
                        end;

                        if not v302 then
                            warn("Aura", Aura, "is not unlocked.");

                            return;
                        end;
                    end;

                    if p300.Aura == Aura and not u299 then
                        warn("Already equipped!");

                        return;
                    end;

                    local v305 = u40[u297];

                    if v305 then
                        v305 = v305:FindFirstChild("Handle");
                    end;

                    local v306;

                    if v305 then
                        local Aura2 = v305:FindFirstChild("Aura");

                        if Aura2 then
                            Aura2:Destroy();
                        end;

                        v306 = v305:FindFirstChildOfClass("Attachment");
                    else
                        v306 = nil;
                    end;

                    if u298 and u298.Effect:IsA("BasePart") then
                        local v307 = u298.Effect:Clone();
                        v307.Name = "Aura";
                        local Attachment = Instance.new("Attachment");
                        Attachment.Name = "AuraMount";
                        Attachment.Parent = v307;
                        local RigidConstraint = Instance.new("RigidConstraint");
                        RigidConstraint.Attachment0 = v306;
                        RigidConstraint.Attachment1 = Attachment;
                        RigidConstraint.Parent = Attachment;

                        for _, child in v307:GetChildren() do
                            if child:IsA("Attachment") then
                                child:AddTag("RelicsAuraAtt");
                                local Name2 = child.Name;

                                if child:IsA("Bone") then
                                    child:SetAttribute("Class", Name2);
                                    child:AddTag("RelicsAuraFx");
                                end;

                                for _, descendant in child:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Bone"))) then
                                        descendant:SetAttribute("Class", Name2);
                                        descendant:AddTag("RelicsAuraFx");
                                    elseif descendant:IsA("BasePart") then
                                        descendant.Massless = true;
                                    end;
                                end;
                            else
                                child:Destroy();
                            end;
                        end;

                        v307.Transparency = 1;
                        v307.CanCollide = false;
                        v307.CanQuery = false;
                        v307.CanTouch = false;
                        v307.Anchored = false;
                        v307.Massless = true;
                        v307.Parent = v305;
                    else
                        Aura = nil;
                    end;

                    p300.Aura = Aura;
                    local UserId2 = u297.UserId;
                    local v308 = u77[UserId2];

                    if not v308 then
                        v308 = {};
                        u77[UserId2] = v308;
                    end;

                    v308.Auras = true;
                    u1.FireClient(u297, "SyncAuraData");
                end);
            end);
        end);
    end;

    getSettingsImpl(UserId):andThen(function(p309) -- Line: 1818
        -- upvalues: onSettingChanged (copy), UserId (copy)
        for i, v in pairs(p309) do
            onSettingChanged(UserId, i, v);
        end;
    end);
    v270:Add(function() -- Line: 1824
        -- upvalues: u63 (ref), PlayerFromCharacter (copy)
        local v310 = u63[PlayerFromCharacter];

        if v310 then
            v310.Maid:Clean();
        end;

        u63[PlayerFromCharacter] = nil;
    end);
    v270:Connect(MarketplaceService.PromptPurchaseFinished, function(p311: userdata, p312: number, p313: boolean) -- Line: 1834
        -- upvalues: getBoomboxConfigs (ref), PlayerFromCharacter (copy), onSettingChanged (copy), u63 (ref), createServerAudio (ref)
        local v314 = getBoomboxConfigs()[1];

        if p313 and (v314 and (p311 == PlayerFromCharacter and p312 == v314.AssetId)) then
            task.defer(function() -- Line: 1839
                -- upvalues: onSettingChanged (ref), PlayerFromCharacter (ref), u63 (ref), createServerAudio (ref)
                onSettingChanged(PlayerFromCharacter.UserId, "BoomboxIdol", true);
                local v315 = PlayerFromCharacter;
                local Character = v315.Character;

                if Character and not u63[v315] then
                    u63[v315] = createServerAudio(Character);
                end;
            end);
        end;
    end);
    v270:Connect(u166, onSettingChanged);
    local Character = PlayerFromCharacter.Character;

    if Character and not u63[PlayerFromCharacter] then
        u63[PlayerFromCharacter] = createServerAudio(Character);
    end;
end;

local function u319(u317: userdata) -- Line: 1850
    -- upvalues: u316 (copy), u267 (ref), loadEncryptedSongs (copy)
    local Character = u317.Character;

    if Character and Character.Parent then
        task.spawn(u316, Character);
    end;

    if u267 then
        u267:andThen(function(p318: table) -- Line: 1858
            -- upvalues: loadEncryptedSongs (ref), u317 (copy)
            for _, v in p318 do
                loadEncryptedSongs(v.songs, u317.UserId);
            end;
        end);
    end;

    u317.CharacterAdded:Connect(u316);
end;

local function onServerInvoke(p320: userdata, p321: string, ...) -- Line: 1868
    -- upvalues: getFavoritesImpl (copy), u77 (copy), Promise (copy), getSettingsImpl (copy), Settings (copy), u166 (copy), getAuraDataImpl (copy), getMaxRolls (copy), Players (copy), u1 (copy), RunContext (copy), u180 (copy)
    local v322;

    if p321 == "GetFavorites" then
        v322 = getFavoritesImpl(p320.UserId);
    elseif p321 == "AddFavorite" then
        local u323 = ...;

        if type(u323) ~= "string" then
            return false, "Invalid song id";
        end;

        local UserId = p320.UserId;
        v322 = getFavoritesImpl(UserId):andThen(function(p324) -- Line: 1042
            -- upvalues: u323 (copy), UserId (copy), u77 (ref), Promise (ref)
            if table.find(p324, u323) then
                return Promise.reject("Song already favorited!");
            end;

            local v325 = UserId;
            local v326 = u77[v325];

            if not v326 then
                v326 = {};
                u77[v325] = v326;
            end;

            v326.Favorites = true;
            table.insert(p324, 1, u323);

            return u323;
        end);
    elseif p321 == "RemoveFavorite" then
        local u327 = ...;

        if type(u327) ~= "string" then
            return false, "Invalid song id";
        end;

        local UserId = p320.UserId;
        v322 = getFavoritesImpl(UserId):andThen(function(p328) -- Line: 1080
            -- upvalues: u327 (copy), UserId (copy), u77 (ref), Promise (ref)
            local table_find_ret = table.find(p328, u327);

            if not table_find_ret then
                return Promise.reject("Song wasn\'t favorited!");
            end;

            table.remove(p328, table_find_ret);
            local v329 = UserId;
            local v330 = u77[v329];

            if not v330 then
                v330 = {};
                u77[v329] = v330;
            end;

            v330.Favorites = true;

            return u327;
        end);
    elseif p321 == "GetSettings" then
        v322 = getSettingsImpl(p320.UserId);
    elseif p321 == "ChangeSetting" then
        local u331, u332 = ...;

        if type(u331) ~= "string" or not Settings[u331] then
            return false, "Invalid key!";
        end;

        if type(u332) ~= "boolean" then
            return false, "Invalid value!";
        end;

        local UserId = p320.UserId;
        v322 = getSettingsImpl(UserId):andThen(function(p333) -- Line: 1198
            -- upvalues: u331 (copy), Promise (ref), u332 (copy), UserId (copy), u77 (ref), u166 (ref)
            if p333[u331] == nil then
                return Promise.reject("Invalid setting key.");
            end;

            p333[u331] = u332;
            local v334 = UserId;
            local v335 = u77[v334];

            if not v335 then
                v335 = {};
                u77[v334] = v335;
            end;

            v335.Settings = true;
            u166:Fire(UserId, u331, u332);

            return p333;
        end);
    elseif p321 == "GetAuraData" then
        local UserId = p320.UserId;
        v322 = getAuraDataImpl(UserId):andThen(function(p336) -- Line: 1346
            -- upvalues: getMaxRolls (ref), UserId (copy), Players (ref), u77 (ref), u1 (ref)
            local v337 = p336.LastRenew or 0;
            local os_time_ret = os.time();

            if os_time_ret - v337 > 86400 then
                local v338, v339 = getMaxRolls(UserId);

                if v339 then
                    local PlayerByUserId = Players:GetPlayerByUserId(UserId);
                    p336.Rolls = v338;
                    p336.LastRenew = os_time_ret;
                    local v340 = UserId;
                    local v341 = u77[v340];

                    if not v341 then
                        v341 = {};
                        u77[v340] = v341;
                    end;

                    v341.Auras = true;

                    if PlayerByUserId then
                        u1.FireClient(PlayerByUserId, "SyncAuraData");
                    end;
                end;
            end;

            return {
                Rolls = p336.Rolls or 0,
                LastRenew = p336.LastRenew or 0,
                Unlocks = p336.Unlocks or {},
                Aura = p336.Aura
            };
        end);
    else
        if p321 ~= "RollForAura" then
            return false, "Invalid function name!";
        end;

        local UserId = p320.UserId;
        v322 = getAuraDataImpl(UserId):andThen(function(p342) -- Line: 1375
            -- upvalues: RunContext (ref), UserId (copy), u77 (ref), u180 (ref), Players (ref), u1 (ref)
            local v343 = p342.Rolls or 0;

            if v343 <= 0 then
                return {
                    Rolled = false
                };
            end;

            local math_random_ret = math.random();

            if not RunContext.IsStudio then
                p342.Rolls = math.max(0, v343 - 1);
            end;

            local v344 = UserId;
            local v345 = u77[v344];

            if not v345 then
                v345 = {};
                u77[v344] = v345;
            end;

            v345.Auras = true;

            if math_random_ret < 0.05 then
                local v346 = {};
                local v347 = 0;

                for i, v in pairs(u180) do
                    local Chance = v.Chance;

                    if Chance > 0 then
                        table.insert(v346, {
                            Name = i,
                            Weight = Chance
                        });
                        v347 = v347 + Chance;
                    end;
                end;

                local v348 = math.random() * v347;
                local v349 = 0;

                for _, v in ipairs(v346) do
                    local v350 = v349 + v.Weight;

                    if v349 <= v348 and v348 <= v350 then
                        local PlayerByUserId = Players:GetPlayerByUserId(UserId);
                        local Name = v.Name;

                        if not p342.Unlocks then
                            p342.Unlocks = {};
                        end;

                        p342.Unlocks[Name] = true;
                        local v351 = UserId;
                        local v352 = u77[v351];

                        if not v352 then
                            v352 = {};
                            u77[v351] = v352;
                        end;

                        v352.Auras = true;

                        if PlayerByUserId then
                            u1.FireClient(PlayerByUserId, "SyncAuraData");
                        end;

                        return {
                            Rolled = true,
                            Roll = math_random_ret,
                            UnlockedAura = Name
                        };
                    end;

                    v349 = v350;
                end;
            end;

            return {
                Rolled = true,
                Roll = math_random_ret
            };
        end);
    end;

    return v322:await();
end;

local function onServerFire(u353: userdata, p354: string, ...) -- Line: 1914
    -- upvalues: getBoomboxConfigs (copy), getOwnership (copy), Promise (copy), u63 (copy), createServerAudio (copy), getSkinImpl (copy), u40 (copy), u77 (copy), u112 (copy), u180 (copy), getAuraDataImpl (copy), CollectionService (copy), u1 (copy)
    local v355 = getBoomboxConfigs();

    if not v355 then
        return;
    end;

    local v356 = {};

    for _, v in ipairs(v355) do
        local v357 = getOwnership(u353, v.AssetId);
        table.insert(v356, v357);
    end;

    local v358 = false;

    if not Promise.allSettled(v356):await() then
        return;
    end;

    for _, v in v356 do
        local v359, v360 = v:await();

        if v359 and v360 then
            v358 = true;
            break;
        end;
    end;

    if not v358 then
        return;
    end;

    local Character = u353.Character;
    local v361 = u63[u353];

    if Character and not v361 then
        v361 = createServerAudio(Character);
        u63[u353] = v361;
    end;

    if not v361 then
        return;
    end;

    if p354 ~= "EquipSkin" then
        if p354 == "EquipAura" then
            local v362 = ...;

            if type(v362) == "nil" then
                local u363 = nil;
                local u364 = u363 and u180[u363];
                local u365 = nil;
                getAuraDataImpl(u353.UserId):andThen(function(p366) -- Line: 1451
                    -- upvalues: u364 (copy), u363 (ref), CollectionService (ref), getOwnership (ref), u353 (copy), u365 (copy), u40 (ref), u77 (ref), u1 (ref)
                    if u364 and not (p366.Unlocks or {})[u363] then
                        local GamePass = u364.GamePass;
                        local v367 = CollectionService:GetTagged("RelicsFeatures")[1];

                        if v367 then
                            v367 = v367:GetAttribute("Demo");
                        end;

                        local v368 = v367 and true or false;

                        if GamePass then
                            local v369, v370 = getOwnership(u353, GamePass, Enum.InfoType.GamePass):await();
                            v368 = v369 and v370 and true or v368;
                        end;

                        if not v368 then
                            warn("Aura", u363, "is not unlocked.");

                            return;
                        end;
                    end;

                    if p366.Aura == u363 and not u365 then
                        warn("Already equipped!");

                        return;
                    end;

                    local v371 = u40[u353];

                    if v371 then
                        v371 = v371:FindFirstChild("Handle");
                    end;

                    local v372;

                    if v371 then
                        local Aura = v371:FindFirstChild("Aura");

                        if Aura then
                            Aura:Destroy();
                        end;

                        v372 = v371:FindFirstChildOfClass("Attachment");
                    else
                        v372 = nil;
                    end;

                    if u364 and u364.Effect:IsA("BasePart") then
                        local v373 = u364.Effect:Clone();
                        v373.Name = "Aura";
                        local Attachment = Instance.new("Attachment");
                        Attachment.Name = "AuraMount";
                        Attachment.Parent = v373;
                        local RigidConstraint = Instance.new("RigidConstraint");
                        RigidConstraint.Attachment0 = v372;
                        RigidConstraint.Attachment1 = Attachment;
                        RigidConstraint.Parent = Attachment;

                        for _, child in v373:GetChildren() do
                            if child:IsA("Attachment") then
                                child:AddTag("RelicsAuraAtt");
                                local Name = child.Name;

                                if child:IsA("Bone") then
                                    child:SetAttribute("Class", Name);
                                    child:AddTag("RelicsAuraFx");
                                end;

                                for _, descendant in child:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Bone"))) then
                                        descendant:SetAttribute("Class", Name);
                                        descendant:AddTag("RelicsAuraFx");
                                    elseif descendant:IsA("BasePart") then
                                        descendant.Massless = true;
                                    end;
                                end;
                            else
                                child:Destroy();
                            end;
                        end;

                        v373.Transparency = 1;
                        v373.CanCollide = false;
                        v373.CanQuery = false;
                        v373.CanTouch = false;
                        v373.Anchored = false;
                        v373.Massless = true;
                        v373.Parent = v371;
                    else
                        u363 = nil;
                    end;

                    p366.Aura = u363;
                    local UserId = u353.UserId;
                    local v374 = u77[UserId];

                    if not v374 then
                        v374 = {};
                        u77[UserId] = v374;
                    end;

                    v374.Auras = true;
                    u1.FireClient(u353, "SyncAuraData");
                end);

                return;
            end;

            if type(v362) ~= "string" then
                return;
            end;

            if u180[v362] then
                local u375 = v362;
                local u376 = u375 and u180[u375];
                local u377 = nil;
                getAuraDataImpl(u353.UserId):andThen(function(p378) -- Line: 1451
                    -- upvalues: u376 (copy), u375 (ref), CollectionService (ref), getOwnership (ref), u353 (copy), u377 (copy), u40 (ref), u77 (ref), u1 (ref)
                    if u376 and not (p378.Unlocks or {})[u375] then
                        local GamePass = u376.GamePass;
                        local v379 = CollectionService:GetTagged("RelicsFeatures")[1];

                        if v379 then
                            v379 = v379:GetAttribute("Demo");
                        end;

                        local v380 = v379 and true or false;

                        if GamePass then
                            local v381, v382 = getOwnership(u353, GamePass, Enum.InfoType.GamePass):await();
                            v380 = v381 and v382 and true or v380;
                        end;

                        if not v380 then
                            warn("Aura", u375, "is not unlocked.");

                            return;
                        end;
                    end;

                    if p378.Aura == u375 and not u377 then
                        warn("Already equipped!");

                        return;
                    end;

                    local v383 = u40[u353];

                    if v383 then
                        v383 = v383:FindFirstChild("Handle");
                    end;

                    local v384;

                    if v383 then
                        local Aura = v383:FindFirstChild("Aura");

                        if Aura then
                            Aura:Destroy();
                        end;

                        v384 = v383:FindFirstChildOfClass("Attachment");
                    else
                        v384 = nil;
                    end;

                    if u376 and u376.Effect:IsA("BasePart") then
                        local v385 = u376.Effect:Clone();
                        v385.Name = "Aura";
                        local Attachment = Instance.new("Attachment");
                        Attachment.Name = "AuraMount";
                        Attachment.Parent = v385;
                        local RigidConstraint = Instance.new("RigidConstraint");
                        RigidConstraint.Attachment0 = v384;
                        RigidConstraint.Attachment1 = Attachment;
                        RigidConstraint.Parent = Attachment;

                        for _, child in v385:GetChildren() do
                            if child:IsA("Attachment") then
                                child:AddTag("RelicsAuraAtt");
                                local Name = child.Name;

                                if child:IsA("Bone") then
                                    child:SetAttribute("Class", Name);
                                    child:AddTag("RelicsAuraFx");
                                end;

                                for _, descendant in child:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Bone"))) then
                                        descendant:SetAttribute("Class", Name);
                                        descendant:AddTag("RelicsAuraFx");
                                    elseif descendant:IsA("BasePart") then
                                        descendant.Massless = true;
                                    end;
                                end;
                            else
                                child:Destroy();
                            end;
                        end;

                        v385.Transparency = 1;
                        v385.CanCollide = false;
                        v385.CanQuery = false;
                        v385.CanTouch = false;
                        v385.Anchored = false;
                        v385.Massless = true;
                        v385.Parent = v383;
                    else
                        u375 = nil;
                    end;

                    p378.Aura = u375;
                    local UserId = u353.UserId;
                    local v386 = u77[UserId];

                    if not v386 then
                        v386 = {};
                        u77[UserId] = v386;
                    end;

                    v386.Auras = true;
                    u1.FireClient(u353, "SyncAuraData");
                end);

                return;
            end;
        elseif p354 == "SetPlaying" then
            local v387 = ...;

            if type(v387) == "boolean" then
                if v387 and not v361.Audio.IsPlaying then
                    v361.Audio:Play();

                    return;
                end;

                if not v387 and v361.Audio.IsPlaying then
                    v361.Audio:Stop();

                    return;
                end;
            end;
        elseif p354 == "SetVolume" then
            local v388 = ...;

            if type(v388) == "number" then
                v361.Fader.Volume = v388;

                return;
            end;
        elseif p354 == "SetSong" then
            local v389 = ...;

            if type(v389) == "string" then
                v361.Audio.Asset = v389;

                return;
            end;
        elseif p354 == "SetTime" then
            local v390 = ...;

            if type(v390) == "number" then
                v361.Audio.TimePosition = v390;
            end;
        end;

        return;
    end;

    local u391 = ...;

    if type(u391) == "nil" then
        local u392 = nil;
        local u393 = nil;
        getSkinImpl(u353.UserId):andThen(function(p394) -- Line: 877
            -- upvalues: u40 (ref), u353 (copy), u392 (copy), u393 (copy), u77 (ref)
            local v395 = u40[u353];

            if v395 then
                v395 = v395:FindFirstChild("Handle");
            end;

            if v395 and v395:IsA("MeshPart") then
                if u392 then
                    local TextureID = v395.TextureID;

                    if not v395:GetAttribute("DefaultSkin") then
                        v395:SetAttribute("DefaultSkin", TextureID);
                    end;

                    v395.TextureID = `rbxassetid://{u392.TextureId}`;
                else
                    local Attribute = v395:GetAttribute("DefaultSkin");

                    if type(Attribute) == "string" then
                        v395.TextureID = Attribute;
                    else
                        v395:SetAttribute("DefaultSkin", v395.TextureID);
                    end;
                end;
            end;

            if p394.Skin ~= u393 then
                p394.Skin = u393;
                local UserId = u353.UserId;
                local v396 = u77[UserId];

                if not v396 then
                    v396 = {};
                    u77[UserId] = v396;
                end;

                v396.UGCSkin = true;
            end;
        end);

        return;
    end;

    if type(u391) ~= "string" then
        return;
    end;

    local v397 = u112[u391];

    if not v397 then
        return;
    end;

    local ItemType = v397.ItemType;
    local LegacyId = v397.LegacyId;
    local u398 = { (getOwnership(u353, v397.ItemId, ItemType)) };

    if LegacyId then
        local v399 = getOwnership(u353, LegacyId, ItemType);
        table.insert(u398, v399);
    end;

    Promise.allSettled(u398):andThen(function() -- Line: 1985
        -- upvalues: u398 (copy), u353 (copy), u391 (copy), u112 (ref), getSkinImpl (ref), u40 (ref), u77 (ref)
        for _, v in u398 do
            if v:expect() then
                local u400 = u353;
                local u401 = u391;
                local u402;

                if u401 then
                    u402 = u112[u401];
                else
                    u402 = u401;
                end;

                getSkinImpl(u400.UserId):andThen(function(p403) -- Line: 877
                    -- upvalues: u40 (ref), u400 (copy), u402 (copy), u401 (copy), u77 (ref)
                    local v404 = u40[u400];

                    if v404 then
                        v404 = v404:FindFirstChild("Handle");
                    end;

                    if v404 and v404:IsA("MeshPart") then
                        if u402 then
                            local TextureID = v404.TextureID;

                            if not v404:GetAttribute("DefaultSkin") then
                                v404:SetAttribute("DefaultSkin", TextureID);
                            end;

                            v404.TextureID = `rbxassetid://{u402.TextureId}`;
                        else
                            local Attribute = v404:GetAttribute("DefaultSkin");

                            if type(Attribute) == "string" then
                                v404.TextureID = Attribute;
                            else
                                v404:SetAttribute("DefaultSkin", v404.TextureID);
                            end;
                        end;
                    end;

                    if p403.Skin ~= u401 then
                        p403.Skin = u401;
                        local UserId = u400.UserId;
                        local v405 = u77[UserId];

                        if not v405 then
                            v405 = {};
                            u77[UserId] = v405;
                        end;

                        v405.UGCSkin = true;
                    end;
                end);

                return;
            end;
        end;
    end);
end;

function u1.ServerInit() -- Line: 2041
    -- upvalues: RunContext (copy), u267 (ref), Playlists (copy), Promise (copy), CollectionService (copy), relicsGET (copy), Players (copy), u319 (copy), u2 (ref), onServerInvoke (copy), u3 (ref), onServerFire (copy), u77 (copy), savePlayerData (copy), u76 (ref)
    if not (RunContext.IsServer or RunContext.IsEdit) then
        warn("[RelicsXYZ] ServerInit can only be called on the server.");

        return;
    end;

    if u267 then
        warn("[RelicsXYZ] ServerInit has already been called.");

        return;
    end;

    if Playlists and Playlists:IsA("ModuleScript") then
        u267 = Promise.new(function(p406, p407) -- Line: 2054
            -- upvalues: Playlists (ref)
            local success, result = pcall(require, Playlists);

            if success then
                success = type(result) == "table";
            end;

            assert(success, "Expected Playlists to be a table.");
            p406(result);
        end);
    else
        local v408 = CollectionService:GetTagged("RelicsFeatures")[1];

        if not v408 and true or v408:GetAttribute("RelicsPlaylists") then
            u267 = Promise.retry(relicsGET, 5, "/v2/roblox/games/playlists");
        end;
    end;

    if u267 then
        u267:andThen(function(p409: table) -- Line: 2073
            local Folder = Instance.new("Folder");
            Folder.Name = "Playlists";
            Folder.Archivable = false;

            for _, v in p409 do
                local Configuration = Instance.new("Configuration");
                Configuration:SetAttribute("Id", v.id);
                Configuration:SetAttribute("Image", v.image);
                Configuration:SetAttribute("IsFree", v.isFree);
                Configuration:SetAttribute("IsActive", v.isActive);
                Configuration.Archivable = false;
                Configuration.Name = v.name;
                Configuration:AddTag("RelicsPlaylist");

                for _, v2 in v.songs do
                    local Configuration2 = Instance.new("Configuration");
                    Configuration2.Name = v2.title;
                    Configuration2:SetAttribute("Id", v2.id);
                    Configuration2:SetAttribute("Artist", v2.artist);
                    Configuration2:AddTag("RelicsSong");
                    Configuration2.Parent = Configuration;
                end;

                Configuration.Parent = Folder;
            end;

            Folder.Parent = script;
        end);
    end;

    Players.PlayerAdded:Connect(u319);
    u2.OnServerInvoke = onServerInvoke;
    u3.OnServerEvent:Connect(onServerFire);
    local task_spawn_ret = task.spawn(function() -- Line: 2109
        -- upvalues: u77 (ref), savePlayerData (ref)
        while task.wait(10) do
            for i in pairs(u77) do
                savePlayerData(i);
            end;

            table.clear(u77);
        end;
    end);
    game:BindToClose(function() -- Line: 2119
        -- upvalues: u76 (ref), task_spawn_ret (copy), u77 (ref), savePlayerData (ref)
        u76 = true;
        task.cancel(task_spawn_ret);

        for i in pairs(u77) do
            savePlayerData(i);
        end;
    end);

    for _, v in Players:GetPlayers() do
        task.spawn(u319, v);
    end;
end;

return u1;