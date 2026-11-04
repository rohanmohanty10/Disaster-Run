 

 

local Resources = game:GetService("ReplicatedStorage"):WaitForChild("Resources");
Resources:WaitForChild("mvpAssets");

local function compile_teammate_animations(p1: userdata) -- Line: 6
    local v2 = {};
    local u3 = "num";

    for _, child in p1:GetChildren() do
        u3 = not tonumber(child.Name) and "str" or u3;
        table.insert(v2, child);
    end;

    table.sort(v2, function(p4, p5) -- Line: 18
        -- upvalues: u3 (ref)
        if u3 == "str" then
            return p4.Name < p5.Name;
        end;

        return tonumber(p4.Name) < tonumber(p5.Name);
    end);

    return v2;
end;

local function has_torso_mesh(p6: userdata?) -- Line: 29
    if not p6 then
        return false;
    end;

    for _, child in p6:GetChildren() do
        if child:IsA("CharacterMesh") and child.BodyPart == Enum.BodyPart.Torso then
            return true;
        end;
    end;

    return false;
end;

local v7 = {
    firstFlow = {
        name = "The First Flow",
        length = 9.616666666666667,
        score_length = 3.666666666666667,
        folder = Resources.mvpAssets.firstFlow,
        animation = Resources.mvpAssets.firstFlow.Animation
    },
    specialGoal = {
        name = "Super Special Goal",
        length = 10.2,
        score_length = 7.05,
        folder = Resources.mvpAssets.specialGoal,
        animation = Resources.mvpAssets.specialGoal.Animation
    },
    isagiDemon = {
        name = "Isagi\'s Demon King Triumph",
        icon = "rbxassetid://77648952681049",
        length = 6,
        score_length = 3.75,
        folder = Resources.mvpAssets.isagiDemon,
        animation = Resources.mvpAssets.isagiDemon.Animation
    },
    yakuzaMVP = {
        name = "Yakuza",
        icon = "rbxassetid://83448315910644",
        score_length = 4.783,
        length = 5.667,
        folder = Resources.mvpAssets.yakuza,
        animation = Resources.mvpAssets.yakuza.Animation
    },
    doneAndDusted = {
        name = "DONE AND DUSTED",
        icon = "rbxassetid://77964872380924",
        length = 5,
        score_length = 0.933,
        folder = Resources.mvpAssets.DoneAndDusted,
        animation = Resources.mvpAssets.DoneAndDusted.Animations.User
    },
    megusplosion = {
        name = "EXPLOSION!!",
        icon = "rbxassetid://96931541981676",
        length = 5,
        score_length = 3.2,
        folder = Resources.mvpAssets.Megumin,
        animation = Resources.mvpAssets.Megumin.Animations.User
    },
    allOutAttack = {
        name = "All-Out Attack",
        icon = "rbxassetid://90172231227687",
        length = 3,
        score_length = 1.6,
        folder = Resources.mvpAssets.AllOutAttack,
        animation = Resources.mvpAssets.AllOutAttack.Animation
    },
    hugoMvp = {
        name = "Hugo, New Generation World XI",
        length = 12.45,
        score_length = 10.783,
        teamate = 1,
        otherTeam = true,
        folder = Resources.mvpAssets.HugoMvp,
        animation = Resources.mvpAssets.HugoMvp.UserAnimation,
        teamateAnimation = { Resources.mvpAssets.HugoMvp.OppAnimation },
        enemiesToUser = CFrame.identity
    },
    retrial = {
        name = "Call For Retrial",
        icon = "rbxassetid://71076610560065",
        score_length = 18.25,
        length = 20.25,
        teamate = 7,
        everyone = true,
        folder = Resources.mvpAssets.retrial,
        animation = Resources.mvpAssets.retrial.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.retrial.people)
    },
    AreYouWatchingMe = {
        name = "Are you watching me?!",
        icon = "rbxassetid://75486401260175",
        score_length = 16.5,
        length = 19.7,
        teamate = 2,
        otherTeam = true,
        folder = Resources.mvpAssets.AreYouWatchingMe,
        animation = Resources.mvpAssets.AreYouWatchingMe.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.AreYouWatchingMe.Animations.V)
    },
    barouHeadToHead = {
        name = "Head-to-Head Action",
        score_length = 4.85,
        length = 9.983,
        teamate = 1,
        otherTeam = true,
        folder = Resources.mvpAssets.BarouHead,
        animation = Resources.mvpAssets.BarouHead.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.BarouHead.Animations.Victim }
    },
    broly = {
        name = "Broly\'s Rage",
        length = 13.317,
        score_length = 8.45,
        folder = Resources.mvpAssets.Broly,
        animation = Resources.mvpAssets.Broly.Animation,
        whitelist = {}
    },
    Shadow = {
        icon = "rbxassetid://98290715956276",
        name = "Black Wind Victory",
        length = 9,
        score_length = 6.25,
        limited = true,
        folder = Resources.mvpAssets.Shadow,
        scorelengthvariants = { { 2, 3.18, 6 }, { 3, 5.44 }, { 4, 6.25 } }
    },
    Sonic = {
        name = "Accelerated Victory",
        length = 8,
        score_length = 6.07,
        limited = true,
        icon = "rbxassetid://110564227805335",
        folder = Resources.mvpAssets.Sonic,
        scorelengthvariants = { { 2, 6.07, 8 }, { 3, 6.07, 9 }, { 4, 5.51, 9 } }
    },
    Pillarman = {
        name = "Ancient Awakening",
        length = 18.41,
        score_length = 15.48,
        icon = "rbxassetid://83703590810711",
        limited = true,
        teamate = 2,
        folder = Resources.mvpAssets.Pillarman,
        animation = Resources.mvpAssets.Pillarman.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.Pillarman.Animations.GemHolder, Resources.mvpAssets.Pillarman.Animations.MaskHolder }
    },
    Ubers = {
        name = "Ubers",
        length = 6.1,
        score_length = 4.47,
        teamate = 2,
        folder = Resources.mvpAssets.Ubers,
        animation = Resources.mvpAssets.Ubers.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.Ubers.Animations["1"], Resources.mvpAssets.Ubers.Animations["2"] }
    },
    hakari = {
        name = "Hakari VS Kashimo",
        icon = "rbxassetid://129010498576913",
        otherTeam = true,
        teamate = 1,
        length = 17.5,
        score_length = 12.1,
        folder = Resources.mvpAssets.HakariKashimo,
        animation = Resources.mvpAssets.HakariKashimo.Winner,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.HakariKashimo.Loser }
    },
    gojovsukuna = {
        name = "Gojo VS Sukuna",
        icon = "rbxassetid://72419547821359",
        otherTeam = true,
        teamate = 1,
        length = 9.5,
        score_length = 7.3,
        limited = true,
        folder = Resources.mvpAssets.GojoVSukuna,
        animation = Resources.mvpAssets.GojoVSukuna.Gojo,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.GojoVSukuna.SukunaScene }
    },
    exe = {
        name = "Round 2",
        icon = "rbxassetid://128333765879854",
        length = 6.48,
        score_length = 4.25,
        limited = true,
        folder = Resources.mvpAssets.exe,
        animation = Resources.mvpAssets.exe.User
    },
    bojack = {
        name = "Servants",
        length = 10,
        score_length = 5.15,
        otherTeam = false,
        teamate = 4,
        limited = true,
        icon = "rbxassetid://109929968279840",
        folder = Resources.mvpAssets.bojack,
        animation = Resources.mvpAssets.bojack.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.bojack.Animations.Servant1,
            Resources.mvpAssets.bojack.Animations.Servant2,
            Resources.mvpAssets.bojack.Animations.Servant3,
            Resources.mvpAssets.bojack.Animations.Servant4
        }
    },
    caught = {
        name = "Last Laugh",
        icon = "rbxassetid://130193085866604",
        length = 18.45,
        score_length = 16.6,
        teamate = 8,
        everyone = true,
        folder = Resources.mvpAssets.Caught,
        animation = Resources.mvpAssets.Caught.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.Caught.Animations.Victim1,
            Resources.mvpAssets.Caught.Animations.Victim2,
            Resources.mvpAssets.Caught.Animations.Victim3,
            Resources.mvpAssets.Caught.Animations.Victim4,
            Resources.mvpAssets.Caught.Animations.Victim5,
            Resources.mvpAssets.Caught.Animations.Victim6,
            Resources.mvpAssets.Caught.Animations.Victim7,
            Resources.mvpAssets.Caught.Animations.Victim8
        }
    },
    bambiettaMVP = {
        name = "Quincy, Voll-Stern-Dich.",
        icon = "rbxassetid://96549499095730",
        length = 13.45,
        score_length = 10.766666666666667,
        folder = Resources.mvpAssets.BambiettaMVP,
        animation = Resources.mvpAssets.BambiettaMVP.Animation
    },
    zantetsu = {
        name = "Canon Zantetsu",
        icon = "rbxassetid://125080303442107",
        length = 13.967,
        score_length = 12.383,
        folder = Resources.mvpAssets.zantetsu,
        animation = Resources.mvpAssets.zantetsu.Animation
    },
    inoMvp = {
        name = "Ino\'s Victory",
        icon = "rbxassetid://102500196177807",
        length = 6.6,
        score_length = 4,
        folder = Resources.mvpAssets.inoMvp,
        animation = Resources.mvpAssets.inoMvp.Animation
    },
    hitMVP = {
        name = "HIT",
        icon = "rbxassetid://92604173821461",
        length = 11.966666666666667,
        score_length = 8.583333333333334,
        folder = Resources.mvpAssets.HitMVP,
        animation = Resources.mvpAssets.HitMVP.Animation
    },
    vipMvp = {
        icon = "",
        name = "VIP",
        length = 15,
        score_length = 13,
        tpMe = true,
        folder = Resources.mvpAssets.vipMvp,
        animation = Resources.mvpAssets.vipMvp.Animation
    },
    kunigamiMvp = {
        icon = "",
        name = "Kunigami\'s Triumph",
        length = 6.2,
        score_length = 2.683333333333333,
        pause = 4.45,
        folder = Resources.mvpAssets.kunigamiMvp,
        animation = Resources.mvpAssets.kunigamiMvp.Animation
    },
    ssj4Mvp = {
        icon = "rbxassetid://81850908241677",
        name = "Super Saiyan 4",
        length = 8,
        score_length = 6.5,
        folder = Resources.mvpAssets.ssj4Mvp,
        animation = Resources.mvpAssets.ssj4Mvp.Animation
    },
    aizen = {
        icon = "rbxassetid://106056676312663",
        name = "Above The Heavens",
        score_length = 9.45,
        length = 11.65,
        teamate = 1,
        folder = Resources.mvpAssets.aizen,
        animation = Resources.mvpAssets.aizen.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.aizen.VictimAnimation }
    },
    aizen2 = {
        name = "Above All Flow",
        length = 15.48,
        score_length = 12.3,
        limited = true,
        icon = "rbxassetid://134039488340858",
        folder = Resources.mvpAssets.aizen2,
        animation = Resources.mvpAssets.aizen2.Animation
    },
    YamatoExit = {
        icon = "rbxassetid://103622252321102",
        name = "Vergil\'s Unforeseen Power",
        length = 15.817,
        score_length = 6.183,
        folder = Resources.mvpAssets.YamatoExit,
        animation = Resources.mvpAssets.YamatoExit.Animations.Vergil
    },
    divineBeatdown = {
        icon = "rbxassetid://124753168603355",
        name = "Divine Beatdown",
        score_length = 11.683,
        length = 14.983,
        folder = Resources.mvpAssets.SSJ4_new,
        animation = Resources.mvpAssets.SSJ4_new.Animations.User
    },
    kaiserTriumph = {
        name = "Kaiser\'s Triumph",
        length = 8.666666666666668,
        score_length = 4.366666666666667,
        folder = Resources.mvpAssets.kaiserTriumph,
        animation = Resources.mvpAssets.kaiserTriumph.Animation
    },
    watchOutMVP = {
        name = "\"Watch out, Isagi...\"",
        length = 10,
        score_length = 7.3,
        folder = Resources.mvpAssets.watchOutMVP,
        animation = Resources.mvpAssets.watchOutMVP.Animation
    },
    oiiTensai = {
        name = "Oii Tensai",
        length = 10.65,
        score_length = 7.85,
        folder = Resources.mvpAssets.oiiTensai,
        animation = Resources.mvpAssets.oiiTensai.Animation
    },
    shidouXCharles = {
        name = "Shidou x Charles",
        length = 6.483,
        score_length = 4.167,
        teamate = 2,
        folder = Resources.mvpAssets.shidouXCharles,
        animation = Resources.mvpAssets.shidouXCharles.Animations.Shidou,
        teamateAnimation = { Resources.mvpAssets.shidouXCharles.Animations.Teammate1, Resources.mvpAssets.shidouXCharles.Animations.Teammate2 }
    },
    amazingFeeling = {
        name = "Amazing Feeling",
        length = 9.083,
        score_length = 5.65,
        folder = Resources.mvpAssets.amazingFeeling,
        animation = Resources.mvpAssets.amazingFeeling.Animation
    },
    isagixhioriMVP = {
        name = "Isagi x Hiori",
        length = 10,
        score_length = 6.417,
        folder = Resources.mvpAssets.isagixhioriMVP,
        animation = Resources.mvpAssets.isagixhioriMVP.Animation
    },
    nagiSeishiro = {
        name = "Inhuman Goal Celebration",
        length = 6.666666666666667,
        score_length = 4.433333333333333,
        folder = Resources.mvpAssets.nagiSeishiro,
        animation = Resources.mvpAssets.nagiSeishiro.Animation
    },
    nagiMvp = {
        name = "Nagi\'s Shout",
        length = 6,
        score_length = 4.433333333333333,
        folder = Resources.mvpAssets.nagiMvp,
        animation = Resources.mvpAssets.nagiMvp.Animation
    },
    ronaldoMvp = {
        name = "SIU!",
        length = 6,
        score_length = 4.433333333333333,
        folder = Resources.mvpAssets.ronaldoMvp,
        animation = Resources.mvpAssets.ronaldoMvp.Animation
    },
    rinTriumph = {
        name = "Rin\'s Triumph",
        length = 7.983333333333333,
        score_length = 2.133333333333333,
        folder = Resources.mvpAssets.rinTriumph,
        animation = Resources.mvpAssets.rinTriumph.Animation
    },
    chigiriTriumph = {
        name = "Chigiri\'s Triumph",
        length = 8.9,
        score_length = 5.4,
        folder = Resources.mvpAssets.chigiriTriumph,
        animation = Resources.mvpAssets.chigiriTriumph.Chigiri
    },
    isagiTriumph = {
        name = "Isagi\'s Triumph",
        length = 14,
        folder = Resources.mvpAssets.IsagiTriumph,
        animation = Resources.mvpAssets.IsagiTriumph.Animation
    },
    FieldKing = {
        name = "King of the Field",
        length = 9,
        folder = Resources.mvpAssets.FieldKing,
        animation = Resources.mvpAssets.FieldKing.Animation
    },
    Dopamine = {
        name = "Dopamine",
        length = 7.466,
        score_length = 4.85,
        folder = Resources.mvpAssets.Dopamine,
        animation = Resources.mvpAssets.Dopamine.Animation
    },
    king = {
        name = "U-20 King",
        length = 6.5,
        folder = Resources.mvpAssets.king,
        animation = Resources.mvpAssets.king.Animation
    },
    explosion = {
        name = "King\'s Explosion",
        icon = "rbxassetid://119927970379107",
        length = 5.333,
        score_length = 0.833,
        folder = Resources.mvpAssets.Explosion,
        animation = Resources.mvpAssets.Explosion.Animation
    },
    executedCelebration = {
        name = "Executed.",
        icon = "rbxassetid://84481639783170",
        length = 7.233,
        folder = Resources.mvpAssets.executedCelebration,
        animation = Resources.mvpAssets.executedCelebration.Animation
    },
    executedOLD = {
        name = "Executed. (Old)",
        icon = "rbxassetid://84481639783170",
        length = 6.15,
        score_length = 3,
        folder = Resources.mvpAssets.executedOld,
        animation = Resources.mvpAssets.executedOld.Animation
    },
    u20 = {
        name = "Isagi\'s U-20 Celebration",
        icon = "rbxassetid://119927970379107",
        length = 23.783,
        teamate = 4,
        folder = Resources.mvpAssets.u20,
        animation = Resources.mvpAssets.u20.Animation,
        customCFrame = CFrame.new(-450.655, 3.002, 1433),
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.u20.AnimationRig1,
            Resources.mvpAssets.u20.AnimationRig2,
            Resources.mvpAssets.u20.AnimationRig3,
            Resources.mvpAssets.u20.AnimationRig4
        }
    },
    Vindication = {
        name = "Vindication",
        length = 15.167,
        icon = "rbxassetid://72633530343044",
        folder = Resources.mvpAssets.Vindication,
        animation = Resources.mvpAssets.Vindication.Animation
    },
    saeGlory = {
        name = "Sae\'s Glory",
        length = 13.3,
        folder = Resources.mvpAssets.SaeGlory,
        animation = Resources.mvpAssets.SaeGlory.Animation,
        randomiseBetween = {
            min = 1,
            max = 100
        }
    },
    saeMvp = {
        name = "Sae, The Dream Crusher",
        length = 10.4,
        folder = Resources.mvpAssets.SaeMvp,
        animation = Resources.mvpAssets.SaeMvp.Animation
    },
    kiyoraMvp = {
        name = "Kiyora\'s Triumph",
        length = 8.767,
        otherTeam = true,
        teamate = 2,
        score_length = 5.3,
        folder = Resources.mvpAssets.KiyoraMvpV2,
        animation = Resources.mvpAssets.KiyoraMvpV2.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.KiyoraMvpV2.Victim1, Resources.mvpAssets.KiyoraMvpV2.Victim2 }
    },
    kiyoraMvpOld = {
        name = "Kiyora\'s Triumph (Old)",
        length = 8.833333333333334,
        otherTeam = true,
        teamate = 2,
        score_length = 5.5,
        folder = Resources.mvpAssets.KiyoraMvp,
        animation = Resources.mvpAssets.KiyoraMvp.Animation,
        enemiesToUser = CFrame.identity,
        randomiseBetween = {
            min = 1,
            max = 2
        },
        teamateAnimation = { Resources.mvpAssets.KiyoraMvp.Victim1, Resources.mvpAssets.KiyoraMvp.Victim2 }
    },
    LyxBestRapper = {
        name = "I ALWAYS COME BACK",
        length = 19.5,
        tpMe = true,
        folder = Resources.mvpAssets.SpringtrapMVP,
        animation = Resources.mvpAssets.SpringtrapMVP.Animations.Animation,
        whitelist = {},
        customCFrame = Resources.mvpAssets.SpringtrapMVP.Model.RootPart.CFrame
    },
    nagiTriumph = {
        name = "Nagi\'s Triumph",
        icon = "rbxassetid://92925137998106",
        length = 12.333333333333334,
        teamate = 3,
        score_length = 1.25,
        folder = Resources.mvpAssets.NagiTriumph,
        animation = Resources.mvpAssets.NagiTriumph.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.NagiTriumph.Victim1, Resources.mvpAssets.NagiTriumph.Victim2, Resources.mvpAssets.NagiTriumph.Victim3 }
    },
    nelisagiMVP = {
        name = "NEL Isagi",
        length = 13.95,
        score_length = 8.633,
        folder = Resources.mvpAssets.NelIsagiMvp,
        animation = Resources.mvpAssets.NelIsagiMvp.Animations.User
    },
    bachiraMVP = {
        name = "Bachira\'s Backflip!",
        length = 9.183,
        score_length = 4.117,
        folder = Resources.mvpAssets.bachiraMVP,
        animation = Resources.mvpAssets.bachiraMVP.Animations.User
    },
    shanksMvp = {
        name = "Passing The Mantle",
        length = 10.467,
        score_length = 5.517,
        icon = "rbxassetid://118053710295758",
        folder = Resources.mvpAssets.shanksMvp,
        animation = Resources.mvpAssets.shanksMvp.Animations.User
    },
    EscanorMVP = {
        name = "Lion Sin of Pride",
        length = 16.45,
        score_length = 12.083,
        otherTeam = true,
        teamate = 2,
        icon = "rbxassetid://81446107771103",
        folder = Resources.mvpAssets.EscanorMVP,
        animation = Resources.mvpAssets.EscanorMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.EscanorMVP.Animations.Victim1, Resources.mvpAssets.EscanorMVP.Animations.Victim2 }
    },
    MightMVP = {
        name = "Hero\'s Might",
        length = 16.483,
        score_length = 9.883,
        otherTeam = true,
        teamate = 3,
        icon = "rbxassetid://80398557739589",
        folder = Resources.mvpAssets.MightMVP,
        animation = Resources.mvpAssets.MightMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.MightMVP.Animations.Enemy1, Resources.mvpAssets.MightMVP.Animations.Enemy2, Resources.mvpAssets.MightMVP.Animations.Enemy3 }
    },
    yukimiyaMVP = {
        name = "Yukimiya\'s Triumph",
        length = 11.4,
        score_length = 6.9,
        icon = "rbxassetid://116888828470844",
        folder = Resources.mvpAssets.yukimiyaMVP,
        animation = Resources.mvpAssets.yukimiyaMVP.Animations.User
    },
    SunKissed = {
        name = "Sun-Kissed Technique",
        length = 13,
        score_length = 4.4,
        icon = "rbxassetid://123794661623790",
        folder = Resources.mvpAssets.SunKissed,
        animation = Resources.mvpAssets.SunKissed.Animation
    },
    GetFunky = {
        name = "Get Funky",
        length = 19.58,
        score_length = 17.2,
        icon = "rbxassetid://121340007202715",
        folder = Resources.mvpAssets.GetFunky,
        animation = Resources.mvpAssets.GetFunky.Animation
    },
    contractMVP = {
        name = "Devil\'s Contract",
        length = 7,
        score_length = 2.2,
        folder = Resources.mvpAssets.DevilsContract,
        animation = Resources.mvpAssets.DevilsContract.Animation
    },
    ReoMVP = {
        name = "Reo, The Master Of All Trades",
        length = 4.28,
        score_length = 2.4,
        folder = Resources.mvpAssets.ReoMVP,
        animation = Resources.mvpAssets.ReoMVP.Animation
    },
    MidorimaMVP = {
        name = "Midorima",
        icon = "rbxassetid://91534418878137",
        length = 9.2,
        score_length = 7.28,
        folder = Resources.mvpAssets.Midorima
    },
    crushedDreams = {
        name = "Crushed Dreams",
        length = 20,
        score_length = 13.717,
        otherTeam = true,
        teamate = 3,
        folder = Resources.mvpAssets.crushedDreams,
        animation = Resources.mvpAssets.crushedDreams.Animations.User,
        enemiesToUser = { CFrame.new(0, 0, -6.357) * CFrame.Angles(0, 3.141592653589793, 0), CFrame.new(26.808, -0.155, 30.494), CFrame.new(-13.875, -0.115, 19.994) },
        teamateAnimation = { Resources.mvpAssets.crushedDreams.Animations.EnemyMain, Resources.mvpAssets.crushedDreams.Animations.Enemy1, Resources.mvpAssets.crushedDreams.Animations.Enemy2 }
    },
    finestClown = {
        name = "My Finest Clown",
        length = 13.333,
        score_length = 9.683,
        teamate = 4,
        icon = "rbxassetid://121495906011172",
        enemiesToUser = CFrame.identity,
        folder = Resources.mvpAssets.finestClown,
        animation = Resources.mvpAssets.finestClown.Animations.User,
        teamateAnimation = {
            Resources.mvpAssets.finestClown.Animations.bumKaiser,
            Resources.mvpAssets.finestClown.Animations.Teammate1,
            Resources.mvpAssets.finestClown.Animations.Teammate2,
            Resources.mvpAssets.finestClown.Animations.Teammate3
        }
    },
    finestJolly = {
        name = "My Finest Jolly",
        length = 15.3,
        score_length = 9.9,
        teamate = 4,
        enemiesToUser = CFrame.identity,
        folder = Resources.mvpAssets.finestJolly,
        animation = Resources.mvpAssets.finestJolly.Animations.User,
        teamateAnimation = {
            Resources.mvpAssets.finestJolly.Animations.jollyKaiser,
            Resources.mvpAssets.finestJolly.Animations.Teammate1,
            Resources.mvpAssets.finestJolly.Animations.Teammate2,
            Resources.mvpAssets.finestJolly.Animations.Teammate3
        }
    },
    thanksgivingMVP = {
        name = "Thanksgiving Party",
        length = 18.983,
        score_length = 15.067,
        otherTeam = false,
        teamate = 4,
        folder = Resources.mvpAssets.thanksgivingMVP,
        animation = Resources.mvpAssets.thanksgivingMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.thanksgivingMVP.Animations.Team1,
            Resources.mvpAssets.thanksgivingMVP.Animations.Team2,
            Resources.mvpAssets.thanksgivingMVP.Animations.Team3,
            Resources.mvpAssets.thanksgivingMVP.Animations.Team4
        }
    },
    giantTurkeyMVP = {
        name = "Giant Turkey",
        length = 13.133,
        score_length = 6.5,
        otherTeam = true,
        teamate = 3,
        folder = Resources.mvpAssets.giantTurkeyMVP,
        animation = Resources.mvpAssets.giantTurkeyMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.giantTurkeyMVP.Animations.Victim1, Resources.mvpAssets.giantTurkeyMVP.Animations.Victim2, Resources.mvpAssets.giantTurkeyMVP.Animations.Victim3 }
    },
    auraMonsterMVP = {
        name = "Return By Death",
        length = 18.3,
        score_length = 16.15,
        icon = "rbxassetid://119774906531758",
        folder = Resources.mvpAssets.auraMonsterMVP,
        animation = Resources.mvpAssets.auraMonsterMVP.Animations.User
    },
    heianPeriod = {
        name = "Heian Era",
        icon = "rbxassetid://70598086542966",
        length = 17.583,
        score_length = 9.267,
        folder = Resources.mvpAssets.heianPeriod,
        animation = Resources.mvpAssets.heianPeriod.Animation
    },
    otoyakarasu = {
        name = "Double Assassins",
        length = 10.52,
        score_length = 8.5,
        otherTeam = false,
        folder = Resources.mvpAssets.otoyakarasu,
        animation = Resources.mvpAssets.otoyakarasu.Animations.Karasu
    },
    kiyoraappraisal = {
        name = "Kiyora\'s Appraisal",
        length = 6,
        score_length = 3.1,
        otherTeam = false,
        teamate = 2,
        folder = Resources.mvpAssets.kiyoraappraisal,
        animation = Resources.mvpAssets.kiyoraappraisal.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.kiyoraappraisal.Animations.Team2, Resources.mvpAssets.kiyoraappraisal.Animations.Team3 }
    },
    saemvp2 = {
        name = "Sae Itoshi\'s Focus",
        length = 13.2,
        score_length = 8.25,
        otherTeam = true,
        teamate = 1,
        folder = Resources.mvpAssets.saemvp2,
        animation = Resources.mvpAssets.saemvp2.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.saemvp2.Animations.Victim }
    },
    aikuMVP = {
        name = "Congratulations.. SOCCER GAME",
        tpMe = true,
        teamate = 5,
        length = 18.45,
        score_length = 13.4,
        folder = Resources.mvpAssets.aikuMVP,
        animation = Resources.mvpAssets.aikuMVP.Animations.User,
        teamateAnimation = {
            Resources.mvpAssets.aikuMVP.Animations.Enemy,
            Resources.mvpAssets.aikuMVP.Animations.Victims[1],
            Resources.mvpAssets.aikuMVP.Animations.Victims[2],
            Resources.mvpAssets.aikuMVP.Animations.Victims[3],
            Resources.mvpAssets.aikuMVP.Animations.Victims[4]
        },
        enemiesToUser = CFrame.identity,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2.2, 0)
    },
    superstarMVP = {
        name = "Superstar",
        length = 16,
        score_length = 12.517,
        score_type = "superstar",
        tpMe = true,
        teamate = 1,
        folder = Resources.mvpAssets.superstarMVP,
        animation = Resources.mvpAssets.superstarMVP.Animations.Kaiser,
        teamateAnimation = { Resources.mvpAssets.superstarMVP.Animations.Isagi },
        enemiesToUser = CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
    },
    isagiNigeriaWC = {
        name = "U-20 WC: Isagi\'s Celebration v Nigeria",
        score_length = 5.6,
        length = 10.633,
        teamate = 3,
        tpMe = true,
        folder = Resources.mvpAssets.U20WC_Nigeria,
        animation = Resources.mvpAssets.U20WC_Nigeria.UserAnimation,
        enemiesToUser = { CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0), CFrame.identity, CFrame.identity },
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.U20WC_Nigeria.Teammates)
    },
    raidenMVP = {
        name = "Raiden",
        length = 5.9,
        score_length = 3,
        teamate = 6,
        icon = "rbxassetid://97592809346332",
        limited = true,
        otherTeam = true,
        tpMe = true,
        folder = Resources.mvpAssets.raidenMVP,
        animation = Resources.mvpAssets.raidenMVP.Animations.Player,
        enemiesToUser = CFrame.new(0, -6.844, 0.034),
        teamateAnimation = {
            Resources.mvpAssets.raidenMVP.Animations.Victims["1"],
            Resources.mvpAssets.raidenMVP.Animations.Victims["2"],
            Resources.mvpAssets.raidenMVP.Animations.Victims["3"],
            Resources.mvpAssets.raidenMVP.Animations.Victims["4"],
            Resources.mvpAssets.raidenMVP.Animations.Victims["5"],
            Resources.mvpAssets.raidenMVP.Animations.Victims["6"]
        }
    },
    dawnwalkerMVP = {
        name = "Dawnwalker",
        length = 12.25,
        score_length = 7.5,
        otherTeam = true,
        teamate = 1,
        tpMe = true,
        folder = Resources.mvpAssets.dawnwalkerMVP,
        animation = Resources.mvpAssets.dawnwalkerMVP.Animations.User,
        customCFrame = CFrame.new(-516.38, 1200, 1500),
        enemiesToUser = CFrame.new(0, 0, -3.5327939987182617) * CFrame.Angles(0, 3.141592653589793, 0),
        teamateAnimation = { Resources.mvpAssets.dawnwalkerMVP.Animations.Victim }
    },
    rienMVP = {
        name = "Rien",
        length = 43,
        score_length = 40,
        otherTeam = true,
        teamate = 4,
        tpMe = true,
        folder = Resources.roland.MVPs.Rien,
        customCFrame = CFrame.new(-60.159, 20.845, -80.281),
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.roland.MVPs.Rien.Animations.Victim1,
            Resources.roland.MVPs.Rien.Animations.Victim2,
            Resources.roland.MVPs.Rien.Animations.Victim3,
            Resources.roland.MVPs.Rien.Animations.Victim4
        },
        whitelist = { 2447122302, 568225745, 4166416054, 9823387274 }
    },
    visionary = {
        name = "Sternritter V, The Visionary",
        length = 14,
        folder = Resources.mvpAssets.gremmyMVP,
        animation = Resources.mvpAssets.gremmyMVP.Animations.User,
        whitelist = { 1911944568, 9823387274, 139232224, 2447122302, 4166416054, 1684644288 }
    },
    nettspendlisteningparty = {
        name = "MY PERFECT VICTORY",
        tpMe = true,
        length = 26,
        score_length = 24,
        folder = Resources.mvpAssets.jimmy1,
        animation = Resources.mvpAssets.jimmy1.Animations.User,
        customCFrame = CFrame.new(9968.1, 61, -127.328) * CFrame.Angles(0, 3.141592653589793, 0),
        whitelist = {}
    },
    remmyava = {
        name = "remmyava",
        teamate = 1,
        length = 16,
        score_length = 14,
        folder = Resources.mvpAssets.remmyava,
        animation = Resources.mvpAssets.remmyava.Animations.User,
        teamateAnimation = { Resources.mvpAssets.remmyava.Animations.Victim },
        whitelist = {}
    },
    nightRaiders = {
        name = "Night Raiders",
        teamate = 5,
        tpMe = true,
        enemyPause = 19.333333333333332,
        length = 21.65,
        score_length = 18,
        folder = Resources.mvpAssets.nightRaiders,
        animation = Resources.mvpAssets.nightRaiders.Animations.User,
        customCFrame = CFrame.new(1086.08, 476.867, -61.535) * CFrame.Angles(0, -1.5707963267948966, 0),
        teamateAnimation = {
            Resources.mvpAssets.nightRaiders.Animations.Victims[1],
            Resources.mvpAssets.nightRaiders.Animations.Victims[2],
            Resources.mvpAssets.nightRaiders.Animations.Victims[3],
            Resources.mvpAssets.nightRaiders.Animations.Victims[4],
            Resources.mvpAssets.nightRaiders.Animations.Victims[5]
        },
        whitelist = { 1911944568, 458595807, 5077795305 },
        enemiesToUser = CFrame.new(0, 0, -4) * CFrame.Angles(0, -3.141592653589793, 0)
    },
    luffyRanked = {
        name = "LuffyRanked",
        otherTeam = true,
        teamate = 5,
        length = 19.7,
        score_length = 18,
        folder = Resources.mvpAssets.luffyRanked,
        animation = Resources.mvpAssets.luffyRanked.Animations.User,
        teamateAnimation = {
            Resources.mvpAssets.luffyRanked.Animations.Victims[1],
            Resources.mvpAssets.luffyRanked.Animations.Victims[2],
            Resources.mvpAssets.luffyRanked.Animations.Victims[3],
            Resources.mvpAssets.luffyRanked.Animations.Victims[4],
            Resources.mvpAssets.luffyRanked.Animations.Victims[5]
        },
        enemiesToUser = CFrame.identity
    },
    vydiaMVP = {
        name = "VydlaMVP",
        tpMe = true,
        teamate = 2,
        length = 11.55,
        score_length = 10,
        folder = Resources.mvpAssets.vydiaMVP,
        animation = Resources.mvpAssets.vydiaMVP.Animations.User,
        customCFrame = CFrame.new(0, 3, 0),
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.vydiaMVP.Animations.Victims[1], Resources.mvpAssets.vydiaMVP.Animations.Victims[2] },
        whitelist = { 911303958, 3518094515, 1911944568, 5077795305, 2447122302, 9823387274, 4166416054 }
    },
    DragonInTheSky = {
        name = "Dragon In The Sky",
        icon = "rbxassetid://126052405142629",
        length = 21.92,
        score_length = 20.14,
        limited = true,
        teamate = 1,
        tpMe = true,
        folder = Resources.mvpAssets.DragonInTheSky,
        animation = Resources.mvpAssets.DragonInTheSky.Animations.User,
        teamateAnimation = { Resources.mvpAssets.DragonInTheSky.Animations.Enemy },
        enemiesToUser = CFrame.identity
    },
    egoists_or_something = {
        name = "Nagi & Barou: Phantom Triumph",
        length = 9.5,
        score_length = 5.533,
        teamate = 1,
        tpMe = true,
        folder = Resources.mvpAssets.egoists_or_something,
        animation = Resources.mvpAssets.egoists_or_something.Animations.User,
        teamateAnimation = { Resources.mvpAssets.egoists_or_something.Animations.Teammate },
        enemiesToUser = CFrame.identity
    },
    listenupMVP = {
        name = "Listen Up",
        length = 16.366666666666667,
        score_length = 14.166666666666666,
        teamate = 1,
        tpMe = true,
        folder = Resources.mvpAssets.listenupMVP,
        animation = Resources.mvpAssets.listenupMVP.Animations.Isagi,
        teamateAnimation = { Resources.mvpAssets.listenupMVP.Animations.Barou },
        enemiesToUser = CFrame.new(0, 0, -4) * CFrame.Angles(0, -3.141592653589793, 0)
    },
    DivineTechniqueMVP = {
        name = "Divine Technique",
        length = 12.133,
        score_length = 5.383,
        limited = true,
        icon = "rbxassetid://116722641895502",
        folder = Resources.mvpAssets.DivineTechniqueMVP,
        animation = Resources.mvpAssets.DivineTechniqueMVP.Animations.User
    },
    Brother = {
        name = "Brother",
        length = 16.25,
        score_length = 12.45,
        limited = true,
        icon = "rbxassetid://137023613279251",
        folder = Resources.mvpAssets.Brother,
        animation = Resources.mvpAssets.Brother.User
    },
    Arachnid = {
        name = "3 Arachnids",
        length = 8,
        score_length = 7.25,
        teamate = 1,
        tpMe = true,
        limited = true,
        icon = "rbxassetid://111519918013125",
        folder = Resources.mvpAssets.Arachnid,
        animation = Resources.mvpAssets.Arachnid.Animations.User,
        teamateAnimation = { Resources.mvpAssets.Arachnid.Animations.Teammate },
        enemiesToUser = CFrame.identity
    },
    CursedRidicule = {
        icon = "rbxassetid://125932690445880",
        name = "Cursed Ridicule",
        score_length = 13.8,
        length = 20.967,
        teamate = 2,
        otherTeam = true,
        folder = Resources.mvpAssets.CursedRidicule,
        animation = Resources.mvpAssets.CursedRidicule.Animations.Teammate1,
        enemiesToUser = { Resources.mvpAssets.CursedRidicule.VFX["2nd evil dude"]:GetPivot():ToObjectSpace(Resources.mvpAssets.CursedRidicule.VFX["1st evil dude"]:GetPivot()), Resources.mvpAssets.CursedRidicule.VFX["2nd evil dude"]:GetPivot():ToObjectSpace(Resources.mvpAssets.CursedRidicule.VFX["3rd"]:GetPivot()) },
        teamateAnimation = { Resources.mvpAssets.CursedRidicule.Animations.User, Resources.mvpAssets.CursedRidicule.Animations.Teammate2 }
    },
    saeXShidou = {
        name = "Sae X Shidou",
        score_length = 12.333333333333334,
        length = 15.066666666666666,
        teamate = 2,
        folder = Resources.mvpAssets.saeXShidou,
        animation = Resources.mvpAssets.saeXShidou.Shidou,
        enemiesToUser = { CFrame.new(
                2.18300056,
                9.53674316e-7,
                12.4589043,
                1,
                -1.50249603e-25,
                -4.54747351e-13,
                -1.50249603e-25,
                1,
                8.81072992e-13,
                -4.54747351e-13,
                8.81072992e-13,
                1
            ), CFrame.new(
                -2.40699959,
                0,
                12.6729021,
                1,
                -1.50249603e-25,
                -4.54747351e-13,
                -1.50249603e-25,
                1,
                8.81072992e-13,
                -4.54747351e-13,
                8.81072992e-13,
                1
            ) },
        teamateAnimation = { Resources.mvpAssets.saeXShidou.Teammate1, Resources.mvpAssets.saeXShidou.Teammate2 }
    },
    rinTriumphV2 = {
        name = "Rin\'s Triumph V2",
        score_length = 1.6333333333333333,
        length = 7.2,
        folder = Resources.mvpAssets.rinTriumphV2,
        animation = Resources.mvpAssets.rinTriumphV2.Animation
    },
    sparkle = {
        name = "Sparkle MVP Sugoi",
        length = 18.06,
        score_length = 15,
        limited = true,
        icon = "rbxassetid://112151450178323",
        folder = Resources.mvpAssets.sparkle,
        animation = Resources.mvpAssets.sparkle.User
    },
    EvernightMVP = {
        icon = "rbxassetid://123778043896405",
        name = "Evernight",
        length = 18.317,
        score_length = 12.917,
        otherTeam = true,
        teamate = 1,
        folder = Resources.mvpAssets.EvernightMvpV2,
        animation = Resources.mvpAssets.EvernightMvpV2.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.EvernightMvpV2.Victim1 }
    },
    ironMouseTuffMVP = {
        name = "Metal Rat Strong",
        length = 13.2,
        score_length = 8.4,
        teamate = 1,
        folder = Resources.mvpAssets.ironMouseTuffMVP,
        animation = Resources.mvpAssets.ironMouseTuffMVP.Animation,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.ironMouseTuffMVP.EmptyAnimation },
        whitelist = { 9823387274 }
    },
    pixelatedMVP = {
        name = "PIXELATED MVP",
        length = 13.5,
        score_length = 11.7,
        folder = Resources.mvpAssets.PixelatedMvp,
        animation = Resources.mvpAssets.PixelatedMvp.Animations.User
    },
    testerMVP = {
        name = "Akashi",
        teamate = 1,
        otherTeam = true,
        length = 21.56,
        score_length = 19,
        folder = Resources.mvpAssets.TesterMVP,
        animation = Resources.mvpAssets.TesterMVP.Winner,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.TesterMVP.Loser },
        whitelist = {}
    },
    pear = {
        name = "I\'M A PEAR",
        length = 5,
        score_length = 2.845,
        folder = Resources.mvpAssets.Pear,
        animation = Resources.mvpAssets.Pear.Animation
    },
    TripleTMVP = {
        name = "IM SORRY",
        length = 3.6,
        score_length = 0.67,
        folder = Resources.mvpAssets.TripleTMVP,
        animation = Resources.mvpAssets.PixelatedMvp.Animations.User
    },
    saeNextLevel = {
        name = "THE NEXT LEVEL",
        length = 10.55,
        score_length = 8.6,
        folder = Resources.mvpAssets.sae,
        animation = Resources.mvpAssets.sae.awk
    },
    BIGBANGDRIVE = {
        name = "BIG BANG DRIVE!",
        length = 19.85,
        score_length = 18.683,
        folder = Resources.mvpAssets.shidou,
        animation = Resources.mvpAssets.shidou.skill3
    },
    ryuvsyuta = {
        name = "Larpers",
        otherTeam = true,
        teamate = 1,
        length = 28.19,
        score_length = 22.17,
        limited = true,
        icon = "rbxassetid://72085120757107",
        folder = Resources.mvpAssets.ryuvsyuta,
        animation = Resources.mvpAssets.ryuvsyuta.Ryu,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.ryuvsyuta.Yuta }
    },
    polyester = {
        name = "4k 120 fps edit",
        teamate = 1,
        length = 11,
        score_length = 8.41,
        folder = Resources.mvpAssets.polyester,
        enemiesToUser = CFrame.identity
    },
    diavoloMvp = {
        name = "Diavolo\'s Test",
        teamate = 1,
        otherTeam = true,
        length = 28.667,
        score_length = 26.667,
        flow_length = 12.7,
        folder = Resources.mvpAssets.diavolo,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.diavolo.Animations.Polnareff },
        whitelist = {}
    },
    potentialman = {
        name = "Potential Man",
        icon = "rbxassetid://72372347932601",
        length = 12,
        score_length = 10,
        teamate = 1,
        otherTeam = true,
        tpMe = true,
        folder = Resources.mvpAssets.potentialman,
        animation = Resources.mvpAssets.potentialman.Animations.Megumi,
        teamateAnimation = { Resources.mvpAssets.potentialman.Animations.Reggie },
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 100, 0)
    },
    goBeyond = {
        name = "Go Beyond!",
        icon = "rbxassetid://109673292554537",
        length = 6.433333333333334,
        score_length = 5,
        teamate = 1,
        otherTeam = true,
        tpMe = true,
        folder = Resources.mvpAssets.goBeyond,
        animation = Resources.mvpAssets.goBeyond.Animations.User,
        teamateAnimation = { Resources.mvpAssets.goBeyond.Animations.Victims["1"] },
        enemiesToUser = CFrame.new(6.14, 0, 0),
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 100, 0)
    },
    talentedlearners = {
        name = "TALENTED LEARNERS",
        length = 20,
        score_length = 15.833333333333334,
        score_goaway = 1,
        teamate = 3,
        folder = Resources.mvpAssets.talentedlearners,
        animation = Resources.mvpAssets.talentedlearners.Animations.User,
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.talentedlearners.Animations.Victims),
        enemiesToUser = CFrame.identity
    },
    comeback = {
        name = "Comeback",
        icon = "rbxassetid://95010973220925",
        length = 22.366666666666667,
        score_length = 15.833333333333334,
        tpMe = true,
        folder = Resources.mvpAssets.comeback,
        animation = Resources.mvpAssets.comeback.Animations.User,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 100, 0)
    },
    cyberMVP = {
        name = "WISH WE COULD GO TO THE MOON TOGETHER",
        icon = "rbxassetid://88098672585584",
        length = 23,
        everyone = true,
        teamate = 8,
        score_length = 21.3,
        folder = Resources.mvpAssets.cyberMVP,
        animation = Resources.mvpAssets.cyberMVP.Animations.User,
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.cyberMVP.Animations.Victims)
    },
    dmcMVP = {
        name = "JACKPOT",
        icon = "rbxassetid://132939286349750",
        length = 3.0833333333333335,
        score_length = 0.7833333333333333,
        folder = Resources.mvpAssets.dmcMVP,
        animation = Resources.mvpAssets.dmcMVP.Animations.User
    },
    shinrajump = {
        name = "HELP ME PLEASE",
        length = 11.416666666666666,
        score_length = 10,
        score_goaway = 1,
        teamate = 1,
        icon = "rbxassetid://90065916358404",
        folder = Resources.mvpAssets.shinrajump,
        animation = Resources.mvpAssets.shinrajump.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.shinrajump.Animations.Victim }
    },
    sothisishowitfeels = {
        name = "Freedom",
        length = 19,
        score_length = 14.4,
        folder = Resources.mvpAssets.freedom,
        whitelist = { 2447122302, 4166416054, 1102361643, 9823387274 }
    },
    demolishitall = {
        name = "i\'m moving as fast as i can",
        length = 32,
        score_length = 30.25,
        folder = Resources.mvpAssets.demolishitall,
        whitelist = { 2447122302, 4166416054, 1549164509, 1102361643, 4166416054 }
    },
    LucyMvp = {
        name = "I Hate You Lucy",
        score_length = 21.167,
        length = 23.65,
        teamate = 2,
        otherTeam = true,
        folder = Resources.mvpAssets.LucyMvp,
        animation = Resources.mvpAssets.LucyMvp.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = compile_teammate_animations(Resources.mvpAssets.LucyMvp.Animations.Opps),
        whitelist = { 254135401, 67241190, 929501840, 261832676, 469246586, 260526009, 1282291785 }
    },
    sukunaMVP = {
        name = "Unheavenly Restriction",
        otherTeam = true,
        limited = true,
        teamate = 1,
        length = 11.5,
        score_length = 10,
        icon = "rbxassetid://95971958430610",
        folder = Resources.mvpAssets.SukunaMVP,
        animation = Resources.mvpAssets.SukunaMVP.Winner,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.SukunaMVP.Loser }
    },
    kanekimvp = {
        name = "I\'M A GHOUL RAHHHH",
        length = 26.25,
        score_length = 18.42,
        folder = Resources.mvpAssets.kanekimvp,
        animation = Resources.mvpAssets.kanekimvp.Kaneki,
        whitelist = { 261832676, 2447122302, 1911944568 }
    },
    flowerymvp = {
        name = "SORRY TO KEEP YOU WAITING",
        length = 16.933333333333334,
        score_length = 12.933333333333334,
        tpMe = true,
        folder = Resources.mvpAssets.flowerymvp,
        animation = Resources.mvpAssets.flowerymvp.Animations.User,
        customCFrame = CFrame.new(9968.1, 61, -127.328) * CFrame.Angles(0, 3.141592653589793, 0),
        whitelist = { 1038030553, 1911944568, 9823387274, 2447122302, 4166416054, 1684644288 }
    },
    starboymvp = {
        name = "XO MVP",
        length = 11.966666666666667,
        score_length = 8.416666666666666,
        score_goaway = 1,
        folder = Resources.mvpAssets.starboymvp,
        animation = Resources.mvpAssets.starboymvp.Animations.User,
        whitelist = { 1911944568, 9823387274, 2447122302, 4166416054 }
    },
    ulquiorra = {
        name = "Murcielago",
        length = 37.1,
        score_length = 33.56666666666667,
        score_goaway = 1,
        tpMe = true,
        teamate = 1,
        otherTeam = true,
        folder = Resources.mvpAssets.ulquiorra,
        customCFrame = CFrame.new(9968.1, 61, -127.328),
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.ulquiorra.Animations.Victim },
        whitelist = { 2447122302, 4166416054, 1684644288 }
    },
    deathkid = {
        name = "Catboy Kon",
        length = 6,
        score_length = 3,
        score_goaway = 1,
        rankLock = "tester",
        folder = Resources.mvpAssets.deathkid
    },
    nightfallsMVP = {
        name = "Night Falls, Everyone, Close Your Eyes",
        length = 25,
        teamate = 9,
        tpMe = true,
        folder = Resources.mvpAssets.nightfallsMVP,
        animation = Resources.mvpAssets.nightfallsMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        customCFrame = CFrame.new(-60.159, 20.845, -80.281),
        teamateAnimation = {
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["1"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["2"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["3"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["4"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["5"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["6"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["7"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["8"],
            Resources.mvpAssets.nightfallsMVP.Animations.Victims["9"]
        },
        whitelist = { 2447122302, 4166416054, 9823387274, 1911944568, 1684644288 }
    },
    memoryshard = {
        name = "Memory Shard",
        length = 29.9,
        teamate = 5,
        otherTeam = true,
        folder = Resources.mvpAssets.memoryshard,
        animation = Resources.mvpAssets.memoryshard.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.memoryshard.Animations.Victims.Victim1,
            Resources.mvpAssets.memoryshard.Animations.Victims.Victim2,
            Resources.mvpAssets.memoryshard.Animations.Victims.Victim3,
            Resources.mvpAssets.memoryshard.Animations.Victims.Victim4,
            Resources.mvpAssets.memoryshard.Animations.Victims.Victim5
        },
        whitelist = { 2447122302, 4166416054, 619213444, 9823387274, 1684644288 }
    },
    kafkamvp = {
        name = "A Dramatic Irony",
        length = 15.95,
        tpMe = true,
        folder = Resources.mvpAssets.kafkamvp,
        animation = Resources.mvpAssets.kafkamvp.Animations.User,
        customCFrame = CFrame.new(-60.159, 20.845, -80.281),
        whitelist = { 2447122302, 4166416054, 619213444, 9823387274 }
    },
    sorrychichi = {
        name = "SORRY CHICHI",
        length = 34.833333333333336,
        folder = Resources.mvpAssets.sorrychichi,
        animation = Resources.mvpAssets.sorrychichi.Animations.User,
        whitelist = { 2447122302, 4166416054, 619213444, 9823387274 }
    },
    travisMVP = {
        name = "sunset",
        length = 16,
        score_length = 15,
        score_goaway = 1,
        folder = Resources.mvpAssets.travisMVP,
        animation = Resources.mvpAssets.travisMVP.Animations.User,
        whitelist = { 2447122302, 4166416054, 9823387274 }
    },
    jimmymvp1 = {
        name = "GAME ON MVP",
        length = 26.666666666666668,
        folder = Resources.mvpAssets.gameon,
        animation = Resources.mvpAssets.gameon.Animations.User,
        whitelist = { 2447122302, 4166416054, 9823387274, 568225745 }
    },
    leaguemvp = {
        name = "League MVP",
        length = 7.216666666666667,
        score_length = 5.5,
        score_goaway = 1,
        teamate = 2,
        otherTeam = true,
        folder = Resources.mvpAssets.leaguemvp,
        animation = Resources.mvpAssets.leaguemvp.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.leaguemvp.Animations.Enemy1, Resources.mvpAssets.leaguemvp.Animations.Enemy2 }
    },
    jimmymvp2 = {
        name = "GAME OVER MVP",
        length = 25.816666666666666,
        folder = Resources.mvpAssets.gameover,
        animation = Resources.mvpAssets.gameover.Animations.User,
        whitelist = { 2447122302, 4166416054, 9823387274, 568225745 }
    },
    heianvsgang = {
        name = "Sukuna VS Everyone",
        length = 10.25,
        score_length = 8.916666666666666,
        tpMe = true,
        teamate = 1,
        otherTeam = true,
        folder = Resources.mvpAssets.HeianVSGang,
        animation = Resources.mvpAssets.HeianVSGang.Animations.User,
        enemiesToUser = CFrame.identity,
        customCFrame = workspace.map.something.barouU20A.CFrame,
        teamateAnimation = { Resources.mvpAssets.HeianVSGang.Animations.Victims["5"] },
        whitelist = { 2447122302, 4166416054, 9823387274 }
    },
    TheScary = {
        name = "Horror Game",
        limited = false,
        length = 4,
        score_length = 2,
        folder = Resources.mvpAssets.TheScary,
        animation = Resources.mvpAssets.TheScary.Animation
    },
    loreaccuratekaiser = {
        name = "KAISER RAHHHHH",
        length = 11.45,
        score_length = 8.7,
        teamate = 1,
        enemyPause = 5.483333333333333,
        otherTeam = true,
        folder = Resources.mvpAssets.loreaccuratekaiser,
        animation = Resources.mvpAssets.loreaccuratekaiser.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = { Resources.mvpAssets.loreaccuratekaiser.Animations.Isagi },
        whitelist = { 2447122302, 4166416054, 9823387274 }
    },
    JetVSRaiden = {
        name = "LET\'S DANCE",
        length = 16.666666666666668,
        score_length = 14.633333333333333,
        icon = "rbxassetid://114103920618326",
        limited = true,
        tpMe = true,
        folder = Resources.mvpAssets.JetVSRaiden,
        animation = Resources.mvpAssets.JetVSRaiden.Animations.Sam,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2.2, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
    },
    redspace = {
        name = "RED SPACE",
        length = 27.416666666666668,
        endDelay = 0,
        previewDelay = 0,
        otherTeam = true,
        tpMe = true,
        folder = Resources.mvpAssets.redspace,
        animation = Resources.mvpAssets.redspace.User,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2000, 0),
        whitelist = { 2447122302, 4166416054, 9823387274 }
    },
    bunnymvp = {
        name = "Bunny\'s Triumph",
        length = 13.016666666666667,
        score_length = 2.1166666666666667,
        score_goaway = 2,
        score_scale = 0.7,
        pause = 10.616666666666667,
        teamate = 1,
        otherTeam = true,
        folder = Resources.mvpAssets.bunnyMVP,
        score_offset = UDim2.fromScale(0.2, -0.2),
        enemiesToUser = CFrame.new(0.022, -2.455, -0.157) * CFrame.Angles(0, -1.6085303452230142, 0),
        animation = Resources.mvpAssets.bunnyMVP.Animations.Bunny,
        teamateAnimation = { Resources.mvpAssets.bunnyMVP.Animations.Sae }
    },
    chigirimvp = {
        name = "Chigiri\'s Celebration",
        length = 6.416666666666667,
        score_length = 6.116666666666666,
        score_goaway = 1,
        folder = Resources.mvpAssets.chigirimvp,
        animation = Resources.mvpAssets.chigirimvp.Animations.User
    },
    ogurinmvp = {
        name = "ogurinmvp",
        length = 21.966666666666665,
        everyone = true,
        teamate = 9,
        folder = Resources.mvpAssets.ogurinmvp,
        animation = Resources.mvpAssets.ogurinmvp.Animations.User,
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.ogurinmvp.Animations.Victims["1"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["2"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["3"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["4"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["5"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["6"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["7"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["8"],
            Resources.mvpAssets.ogurinmvp.Animations.Victims["9"]
        },
        whitelist = { 2447122302, 4166416054 }
    },
    fatchudbnuuy = {
        name = "fatchudbnuuy",
        everyone = true,
        teamate = 9,
        length = 16,
        tpMe = true,
        score_length = 9,
        score_goaway = 1,
        folder = Resources.mvpAssets.fatchudbnuuy,
        animation = Resources.mvpAssets.fatchudbnuuy.Animations["12"],
        enemiesToUser = CFrame.identity,
        teamateAnimation = {
            Resources.mvpAssets.fatchudbnuuy.Animations["2"],
            Resources.mvpAssets.fatchudbnuuy.Animations["3"],
            Resources.mvpAssets.fatchudbnuuy.Animations["4"],
            Resources.mvpAssets.fatchudbnuuy.Animations["5"],
            Resources.mvpAssets.fatchudbnuuy.Animations["6"],
            Resources.mvpAssets.fatchudbnuuy.Animations["7"],
            Resources.mvpAssets.fatchudbnuuy.Animations["8"],
            Resources.mvpAssets.fatchudbnuuy.Animations["9"],
            Resources.mvpAssets.fatchudbnuuy.Animations["10"]
        },
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2000, 0),
        whitelist = { 2447122302, 4166416054 }
    },
    gokuxzamasu = {
        name = "Goku X Zamasu",
        length = 19.15,
        tpMe = true,
        score_length = 16.566666666666666,
        score_goaway = 3,
        folder = Resources.mvpAssets.gokuxzamasu,
        animation = Resources.mvpAssets.gokuxzamasu.Animations.User,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2000, 0),
        whitelist = { 2447122302, 4166416054 }
    },
    highestintheroom = {
        name = "Highest In The Room",
        length = 41.6,
        tpMe = true,
        folder = Resources.mvpAssets.highestintheroom,
        animation = Resources.mvpAssets.highestintheroom.Animations.User,
        customCFrame = workspace.map.centrePoint.CFrame * CFrame.new(0, 2000, 0),
        whitelist = { 2447122302, 4166416054 }
    },
    doomMVP = {
        name = "Hell answers to ME.",
        limited = true,
        length = 11.9,
        tpMe = true,
        teamate = 2,
        otherTeam = true,
        icon = "rbxassetid://90338815585352",
        folder = Resources.mvpAssets.doomMVP,
        animation = Resources.mvpAssets.doomMVP.Animations.User,
        enemiesToUser = CFrame.identity,
        randomiseBetween = {
            min = 1,
            max = 1000
        },
        teamateAnimation = { Resources.mvpAssets.doomMVP.Animations.Enemy1, Resources.mvpAssets.doomMVP.Animations.Enemy2 }
    }
};
local remiellethingy = Resources.mvpAssets:FindFirstChild("remiellethingy");

if remiellethingy then
    local Animations = remiellethingy.Animations;
    v7.remiellethingy = {
        name = "Remielle",
        length = 38.36666666666667,
        score_length = 36,
        score_goaway = 1,
        tpMe = true,
        folder = remiellethingy,
        animation = Animations.Remielle,
        customCFrame = CFrame.new(9968.1, 61, -127.328),
        isRemielle = has_torso_mesh,

        resolveRoles = function(p8) -- Line: 2151, Name: resolveRoles
            -- upvalues: has_torso_mesh (copy), Animations (copy)
            return not has_torso_mesh(p8) and {
                animation = Animations.Wise
            } or nil;
        end,

        whitelist = { 4166416054, 2447122302 }
    };
end;

local backrooms = Resources.mvpAssets:FindFirstChild("backrooms");

if backrooms then
    v7.backrooms = {
        name = "Backrooms",
        length = 12.15,
        score_length = 11.15,
        tpMe = true,
        folder = backrooms,
        animation = backrooms.Animations.User,
        whitelist = { 4166416054, 2447122302, 432828236, 9823387274 }
    };
end;

local rulerofmyheart = Resources.mvpAssets:FindFirstChild("rulerofmyheart");

if rulerofmyheart then
    local Animations = rulerofmyheart.Animations;
    local table_freeze_ret = table.freeze({
        [4166416054] = true,
        [2327164670] = true
    });

    local function ruler_duo_enemies(p9: userdata?) -- Line: 2191
        -- upvalues: table_freeze_ret (copy)
        local Players = game:GetService("Players");
        local v10;

        if p9 then
            v10 = Players:GetPlayerFromCharacter(p9);
        else
            v10 = p9;
        end;

        if not v10 and (p9 and (p9.Name == "Cutscene Boy" and game:GetService("RunService"):IsClient())) then
            v10 = Players.LocalPlayer;
        end;

        local v11;

        if v10 == nil then
            v11 = false;
        else
            v11 = table_freeze_ret[v10.UserId] == true;
        end;

        return v11;
    end;

    v7.rulerofmyheart = {
        name = "Ruler of my heart",
        length = 30.4,
        score_length = 27.516666666666666,
        tpMe = true,
        otherTeam = true,
        teamate = 2,
        folder = rulerofmyheart,
        animation = Animations.Enemy,
        customCFrame = CFrame.new(9968.1, 61, -127.328),
        teamateAnimation = { Animations.User, Animations.EnemyDuo },
        enemiesToUser = { CFrame.identity, CFrame.identity },
        duoEnemies = ruler_duo_enemies,

        resolveRoles = function(p12: userdata?) -- Line: 2218, Name: resolveRoles
            -- upvalues: ruler_duo_enemies (copy), Animations (copy)
            return ruler_duo_enemies(p12) and {
                teamateAnimation = false,
                animation = Animations.User
            } or nil;
        end,

        whitelist = { 2447122302, 4166416054 }
    };
end;

return v7;