 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local packets = require(ReplicatedStorage.packets);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local v1 = {};
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = nil;

local function getGui() -- Line: 33
    -- upvalues: PlayerGui (copy)
    return PlayerGui:WaitForChild("VotePoll");
end;

local function playSound(p6: string) -- Line: 37
    -- upvalues: ReplicatedStorage (copy), soundUtil (copy), SoundService (copy)
    local Resources = ReplicatedStorage:FindFirstChild("Resources");

    if Resources then
        Resources = Resources:FindFirstChild(p6);
    end;

    if Resources and Resources:IsA("Sound") then
        soundUtil:play(Resources, SoundService);
    end;
end;

local function collect(p7: userdata) -- Line: 46
    -- upvalues: u2 (copy)
    local v8 = u2[p7];

    if v8 then
        return v8;
    end;

    local u9 = {};

    local function add(p10: userdata, p11: string) -- Line: 55
        -- upvalues: u9 (copy)
        local v12 = p10[p11];

        if typeof(v12) == "number" then
            table.insert(u9, {
                instance = p10,
                property = p11,
                opaque = v12
            });
        end;
    end;

    local BackgroundTransparency = p7.BackgroundTransparency;

    if typeof(BackgroundTransparency) == "number" then
        table.insert(u9, {
            property = "BackgroundTransparency",
            instance = p7,
            opaque = BackgroundTransparency
        });
    end;

    for _, descendant in p7:GetDescendants() do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            local BackgroundTransparency2 = descendant.BackgroundTransparency;

            if typeof(BackgroundTransparency2) == "number" then
                table.insert(u9, {
                    property = "BackgroundTransparency",
                    instance = descendant,
                    opaque = BackgroundTransparency2
                });
            end;

            local TextTransparency = descendant.TextTransparency;

            if typeof(TextTransparency) == "number" then
                table.insert(u9, {
                    property = "TextTransparency",
                    instance = descendant,
                    opaque = TextTransparency
                });
            end;

            local TextStrokeTransparency = descendant.TextStrokeTransparency;

            if typeof(TextStrokeTransparency) == "number" then
                table.insert(u9, {
                    property = "TextStrokeTransparency",
                    instance = descendant,
                    opaque = TextStrokeTransparency
                });
            end;
        elseif descendant:IsA("UIStroke") then
            local Transparency = descendant.Transparency;

            if typeof(Transparency) == "number" then
                table.insert(u9, {
                    property = "Transparency",
                    instance = descendant,
                    opaque = Transparency
                });
            end;
        end;
    end;

    u2[p7] = u9;

    return u9;
end;

local function fade(p13: userdata, p14: boolean) -- Line: 80
    -- upvalues: collect (copy), TweenService (copy), TweenInfo_new_ret (copy)
    for _, v in collect(p13) do
        TweenService:Create(v.instance, TweenInfo_new_ret, {
            [v.property] = p14 and 1 or v.opaque
        }):Play();
    end;
end;

local function refreshEnabled(p15: userdata) -- Line: 88
    local Poll = p15:WaitForChild("Poll");
    local Results = p15:WaitForChild("Results");
    p15.Enabled = Poll.Visible or Results.Visible;
end;

local function show(p16: userdata, p17: userdata) -- Line: 95
    -- upvalues: u3 (copy), collect (copy), fade (copy)
    u3[p17] = (u3[p17] or 0) + 1;

    for _, v in collect(p17) do
        v.instance[v.property] = 1;
    end;

    p17.Visible = true;
    p16.Enabled = true;
    fade(p17, false);
end;

local function hide(u18: userdata, u19: userdata) -- Line: 108
    -- upvalues: u3 (copy), fade (copy), TweenInfo_new_ret (copy)
    if not u19.Visible then
        return;
    end;

    local u20 = (u3[u19] or 0) + 1;
    u3[u19] = u20;
    fade(u19, true);
    task.delay(TweenInfo_new_ret.Time, function() -- Line: 118
        -- upvalues: u3 (ref), u19 (copy), u20 (copy), u18 (copy)
        if u3[u19] ~= u20 then
            return;
        end;

        u19.Visible = false;
        local v21 = u18;
        local Poll = v21:WaitForChild("Poll");
        local Results = v21:WaitForChild("Results");
        v21.Enabled = Poll.Visible or Results.Visible;
    end);
end;

local function disconnectAll() -- Line: 128
    -- upvalues: u4 (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);
end;

local function split(p22: number, p23: number) -- Line: 136
    local v24 = p22 + p23;

    if v24 <= 0 then
        return 0, 0;
    end;

    local math_round_ret = math.round(p22 / v24 * 100);

    return math_round_ret, 100 - math_round_ret;
end;

function v1.votePoll(u25: string, p26: string, p27: string, p28: string, u29: number) -- Line: 148
    -- upvalues: PlayerGui (copy), u4 (copy), u5 (ref), packets (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), hide (copy), u3 (copy), collect (copy), fade (copy)
    local VotePoll = PlayerGui:WaitForChild("VotePoll");
    local Poll = VotePoll:WaitForChild("Poll");
    local Results = VotePoll:WaitForChild("Results");
    local Question = Poll:WaitForChild("Question");
    local Timer = Poll:WaitForChild("Timer");
    local Option1 = Poll:WaitForChild("Option1");
    local Option2 = Poll:WaitForChild("Option2");

    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);
    u5 = u25;
    Question.Text = p26;
    Option1.Text = p27;
    Option2.Text = p28;
    Timer.Text = `{u29}s left`;

    local function submit(p30: number) -- Line: 166
        -- upvalues: u5 (ref), u25 (copy), u4 (ref), packets (ref), ReplicatedStorage (ref), soundUtil (ref), SoundService (ref), hide (ref), VotePoll (copy), Poll (copy)
        if u5 ~= u25 then
            return;
        end;

        u5 = nil;

        for _, v in u4 do
            v:Disconnect();
        end;

        table.clear(u4);
        packets.bytenet_pollVote.send({
            pollId = u25,
            choice = p30
        });
        local Resources = ReplicatedStorage:FindFirstChild("Resources");

        if Resources then
            Resources = Resources:FindFirstChild("click");
        end;

        if Resources and Resources:IsA("Sound") then
            soundUtil:play(Resources, SoundService);
        end;

        hide(VotePoll, Poll);
    end;

    table.insert(u4, Option1.MouseButton1Click:Connect(function() -- Line: 179
        -- upvalues: submit (copy)
        submit(1);
    end));
    table.insert(u4, Option2.MouseButton1Click:Connect(function() -- Line: 183
        -- upvalues: submit (copy)
        submit(2);
    end));
    hide(VotePoll, Results);
    u3[Poll] = (u3[Poll] or 0) + 1;

    for _, v in collect(Poll) do
        v.instance[v.property] = 1;
    end;

    Poll.Visible = true;
    VotePoll.Enabled = true;
    fade(Poll, false);
    local Resources = ReplicatedStorage:FindFirstChild("Resources");

    if Resources then
        Resources = Resources:FindFirstChild("notisound");
    end;

    if Resources and Resources:IsA("Sound") then
        soundUtil:play(Resources, SoundService);
    end;

    task.spawn(function() -- Line: 191
        -- upvalues: u29 (copy), u5 (ref), u25 (copy), Timer (copy), u4 (ref), hide (ref), VotePoll (copy), Poll (copy)
        local v31 = os.clock() + u29;

        while u5 == u25 do
            local v32 = v31 - os.clock();
            local math_ceil_ret = math.ceil(v32);

            if math_ceil_ret <= 0 then
                break;
            end;

            Timer.Text = `{math_ceil_ret}s left`;
            task.wait(0.2);
        end;

        if u5 ~= u25 then
            return;
        end;

        u5 = nil;

        for _, v in u4 do
            v:Disconnect();
        end;

        table.clear(u4);
        hide(VotePoll, Poll);
    end);
end;

function v1.voteResults(p33: string, p34: string, p35: string, p36: number, p37: number) -- Line: 215
    -- upvalues: PlayerGui (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), hide (copy), u3 (copy), collect (copy), fade (copy)
    local VotePoll = PlayerGui:WaitForChild("VotePoll");
    local Results = VotePoll:WaitForChild("Results");
    local Question = Results:WaitForChild("Question");
    local Result1 = Results:WaitForChild("Result1");
    local Result2 = Results:WaitForChild("Result2");
    local Total = Results:WaitForChild("Total");
    local Close = Results:WaitForChild("Close");
    local v38 = p36 + p37;
    local v39 = p36 + p37;
    local v40, v41;

    if v39 <= 0 then
        v40 = 0;
        v41 = 0;
    else
        v40 = math.round(p36 / v39 * 100);
        v41 = 100 - v40;
    end;

    Question.Text = p33;
    Result1.Text = `{p34}: {p36} ({v40}%)`;
    Result2.Text = `{p35}: {p37} ({v41}%)`;
    Total.Text = v38 == 1 and "1 vote" or `{v38} votes`;
    Close.Text = "Close";
    Close.MouseButton1Click:Once(function() -- Line: 234
        -- upvalues: ReplicatedStorage (ref), soundUtil (ref), SoundService (ref), hide (ref), VotePoll (copy), Results (copy)
        local Resources = ReplicatedStorage:FindFirstChild("Resources");

        if Resources then
            Resources = Resources:FindFirstChild("click");
        end;

        if Resources and Resources:IsA("Sound") then
            soundUtil:play(Resources, SoundService);
        end;

        hide(VotePoll, Results);
    end);
    u3[Results] = (u3[Results] or 0) + 1;

    for _, v in collect(Results) do
        v.instance[v.property] = 1;
    end;

    Results.Visible = true;
    VotePoll.Enabled = true;
    fade(Results, false);
    local Resources = ReplicatedStorage:FindFirstChild("Resources");

    if Resources then
        Resources = Resources:FindFirstChild("notisound");
    end;

    if Resources and Resources:IsA("Sound") then
        soundUtil:play(Resources, SoundService);
    end;
end;

return v1;