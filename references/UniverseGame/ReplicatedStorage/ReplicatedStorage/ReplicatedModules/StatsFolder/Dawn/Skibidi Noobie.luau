  

 

return {
    Inherit = {
        AbilityName = "Dawn"
    },
    Sounds = {
        Breakthrough = {
            SoundId = 88108686,
            Volume = 0.5
        },
        Radiance = {
            SoundId = 16190757458,
            Volume = 0.5,
            Looped = true
        },
        Enchant = {
            SoundId = 17612604233,
            Volume = 0.3
        },
        FlamesBlessing = {
            SoundId = 17026550331,
            Volume = 1.5,
            PlaybackSpeed = 1.5
        },
        ["Flame Strikes"] = {
            SoundId = 16190757458,
            Volume = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(2.608684807256236, 3.151655328798186)
        },
        ["LMB Slam"] = {
            SoundId = 16190757458,
            Volume = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(5.076235827664399, 5.280317460317461)
        },
        Sweep = {
            SoundId = 16190757458,
            Volume = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(10.207596371882087, 10.836281179138322)
        },
        GrandDescension = {
            SoundId = 55607108,
            Volume = 0.65
        },
        ["GrandDescension-Startup"] = {
            SoundId = 55607108,
            Volume = 0.4
        },
        ["GrandDescension-Slam"] = {
            SoundId = 18335741372,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 16190757458,
            Volume = 0.5,
            Looped = true
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://17026550331",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A 4th dimensional bubble, cast a 3 dimensional shadow. It is beyond... COMPREHENSION!"
                        } }
                }, {
                    SoundId = "rbxassetid://14044025744",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Well, I only have bones. Yohoho!"
                        } }
                }, {
                    SoundId = "rbxassetid://126925897482137",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "SHIKANOKO NOKONOKO KOSHITANTAN"
                        } }
                }, {
                    SoundId = "rbxassetid://18441091020",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What was that?"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(u1) -- Line: 119, Name: PostRig
            local InsertService = game:GetService("InsertService");
            task.spawn(function() -- Line: 121
                -- upvalues: InsertService (copy), u1 (copy)
                for _, v in { 4527450728, 10060525, 33070696, 33070696, 33070696, 33070696, 33070696, 33070696, 33070696 } do
                    task.spawn(function() -- Line: 123
                        -- upvalues: InsertService (ref), v (copy), u1 (ref)
                        for _, child in InsertService:LoadAsset(v):GetChildren() do
                            child.Parent = u1.Character;
                        end;
                    end);
                end;
            end);
            local _ = u1.Character;
            local u2 = u1.RigContainer:Get("MainRig");
            local success, result = pcall(game.Players.GetHumanoidDescriptionFromUserId, game.Players, 21141528);
            local u3 = result;

            if success and u3 then
                for _, child in u2.Handle.Noobie:GetChildren() do
                    if child:IsA("Accessory") then
                        child:Destroy();
                    end;
                end;

                u2.Handle.Noobie.Head.Color = u3.HeadColor;
                local v4 = {
                    Hat = {},
                    Face = {},
                    Hair = {}
                };

                for _, v in string.split(u3.HatAccessory, ",") do
                    table.insert(v4.Hat, v);
                end;

                for _, v in string.split(u3.FaceAccessory, ",") do
                    table.insert(v4.Face, v);
                end;

                for _, v in string.split(u3.HairAccessory, ",") do
                    table.insert(v4.Hair, v);
                end;

                task.spawn(function() -- Line: 167
                    -- upvalues: u3 (ref), InsertService (copy), u2 (copy)
                    if u3.Face == 0 then
                        return;
                    end;

                    local v5 = InsertService:LoadAsset(u3.Face):GetChildren()[1];

                    if v5:IsA("Decal") ~= true then
                        return;
                    end;

                    u2.Handle.Noobie.Head.face.Texture = v5.Texture;
                end);

                local function AddAccessory(p6, p7) -- Line: 148
                    -- upvalues: InsertService (copy), u2 (copy)
                    local v8 = InsertService:LoadAsset(p6);

                    if v8 then
                        local Handle = v8:GetChildren()[1].Handle;
                        local v9 = Handle:FindFirstChildWhichIsA("Attachment");
                        local v10 = u2.Handle.Noobie.Head:FindFirstChild(v9.Name);

                        if v10 then
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = u2.Handle.Noobie.Head;
                            Weld.Part1 = Handle;
                            Weld.C0 = v10.CFrame * v9.CFrame:Inverse();
                            Weld.Parent = u2.Handle.Noobie.Head;
                            Handle.CanCollide = false;
                            Handle.Massless = true;
                            Handle.Parent = u2.Handle.Noobie;
                        end;
                    end;
                end;

                for i, v in v4 do
                    for _, v2 in v do
                        task.spawn(AddAccessory, v2, i);
                    end;
                end;
            end;
        end
    }
};