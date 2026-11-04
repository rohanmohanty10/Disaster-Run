 

 

local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));

return table.freeze({
    Enabled = true,
    SampleInterval = 0,
    HandRadius = 3.05,
    HitHalfWidth = 1.4,
    RunnerRadius = 0.9,
    ContactPadding = 0.35,
    MinForward = -0.5,
    Height = 2.8,
    OverlapRadius = 1.9,
    BotBoxScale = 0.95,
    ReachDistance = 12,
    ReachHalfAngle = 75,
    ReachFadeRate = 18,
    TrackingWeight = 0.45,
    WindupWeight = 0.9,
    CommitBaseDistance = 2.15,
    CommitLeadTime = 0.07,
    CommitDistance = 5.25,
    CommitHalfAngle = 65,
    Windup = 0.12,
    ActiveDuration = 0.18,
    Recovery = 0.55,
    WindupAimLimit = 20,
    WindupAimRate = 180,
    MaxObservedSpeed = 90,
    MaxSweepGap = 0.15,
    MaxSweepDistance = 12,
    BoxScale = FFlags.ServerHits and 1 or 0.95
});