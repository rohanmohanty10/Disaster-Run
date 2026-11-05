  

 

local v1 = {
    REFERENCE_GRAVITY = 196.2,
    DEFAULT_MAX_FRICTION_TORQUE = 60,
    HEAD_LIMITS = {
        UpperAngle = 45,
        TwistLowerAngle = -40,
        TwistUpperAngle = 40,
        FrictionTorque = 400,
        ReferenceMass = 1.0249234437943
    },
    WAIST_LIMITS = {
        UpperAngle = 20,
        TwistLowerAngle = -40,
        TwistUpperAngle = 20,
        FrictionTorque = 750,
        ReferenceMass = 2.861558675766
    },
    ANKLE_LIMITS = {
        UpperAngle = 10,
        TwistLowerAngle = -10,
        TwistUpperAngle = 10,
        ReferenceMass = 0.43671694397926
    },
    ELBOW_LIMITS = {
        UpperAngle = 20,
        TwistLowerAngle = 5,
        TwistUpperAngle = 120,
        ReferenceMass = 0.70196455717087
    },
    WRIST_LIMITS = {
        UpperAngle = 30,
        TwistLowerAngle = -10,
        TwistUpperAngle = 10,
        ReferenceMass = 0.69132566452026
    },
    KNEE_LIMITS = {
        UpperAngle = 5,
        TwistLowerAngle = -120,
        TwistUpperAngle = -5,
        ReferenceMass = 0.65389388799667
    },
    SHOULDER_LIMITS = {
        UpperAngle = 110,
        TwistLowerAngle = -85,
        TwistUpperAngle = 85,
        FrictionTorque = 600,
        ReferenceMass = 0.90918225049973
    },
    HIP_LIMITS = {
        UpperAngle = 40,
        TwistLowerAngle = -5,
        TwistUpperAngle = 80,
        FrictionTorque = 600,
        ReferenceMass = 1.9175016880035
    },
    R6_HEAD_LIMITS = {
        UpperAngle = 30,
        TwistLowerAngle = -40,
        TwistUpperAngle = 40
    },
    R6_SHOULDER_LIMITS = {
        UpperAngle = 110,
        TwistLowerAngle = -85,
        TwistUpperAngle = 85
    },
    R6_HIP_LIMITS = {
        UpperAngle = 40,
        TwistLowerAngle = -5,
        TwistUpperAngle = 80
    },
    V3_ZERO = Vector3.new(),
    V3_UP = Vector3.new(0, 1, 0),
    V3_DOWN = Vector3.new(0, -1, 0),
    V3_RIGHT = Vector3.new(1, 0, 0),
    V3_LEFT = Vector3.new(-1, 0, 0)
};
v1.R15_ADDITIONAL_ATTACHMENTS = {
    {
        "UpperTorso",
        "RightShoulderRagdollAttachment",
        CFrame.fromMatrix(v1.V3_ZERO, v1.V3_RIGHT, v1.V3_UP),
        "RightShoulderRigAttachment"
    },
    {
        "RightUpperArm",
        "RightShoulderRagdollAttachment",
        CFrame.fromMatrix(v1.V3_ZERO, v1.V3_DOWN, v1.V3_RIGHT),
        "RightShoulderRigAttachment"
    },
    {
        "UpperTorso",
        "LeftShoulderRagdollAttachment",
        CFrame.fromMatrix(v1.V3_ZERO, v1.V3_LEFT, v1.V3_UP),
        "LeftShoulderRigAttachment"
    },
    {
        "LeftUpperArm",
        "LeftShoulderRagdollAttachment",
        CFrame.fromMatrix(v1.V3_ZERO, v1.V3_DOWN, v1.V3_LEFT),
        "LeftShoulderRigAttachment"
    }
};
v1.R15_RAGDOLL_RIG = {
    RootPart = {},
    Head = {
        "UpperTorso",
        "Head",
        "NeckRigAttachment",
        v1.HEAD_LIMITS
    },
    UpperTorso = {
        "LowerTorso",
        "UpperTorso",
        "WaistRigAttachment",
        v1.WAIST_LIMITS
    },
    LeftUpperArm = {
        "UpperTorso",
        "LeftUpperArm",
        "LeftShoulderRagdollAttachment",
        v1.SHOULDER_LIMITS
    },
    LeftLowerArm = {
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftElbowRigAttachment",
        v1.ELBOW_LIMITS
    },
    LeftHand = {
        "LeftLowerArm",
        "LeftHand",
        "LeftWristRigAttachment",
        v1.WRIST_LIMITS
    },
    RightUpperArm = {
        "UpperTorso",
        "RightUpperArm",
        "RightShoulderRagdollAttachment",
        v1.SHOULDER_LIMITS
    },
    RightLowerArm = {
        "RightUpperArm",
        "RightLowerArm",
        "RightElbowRigAttachment",
        v1.ELBOW_LIMITS
    },
    RightHand = {
        "RightLowerArm",
        "RightHand",
        "RightWristRigAttachment",
        v1.WRIST_LIMITS
    },
    LeftUpperLeg = {
        "LowerTorso",
        "LeftUpperLeg",
        "LeftHipRigAttachment",
        v1.HIP_LIMITS
    },
    LeftLowerLeg = {
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftKneeRigAttachment",
        v1.KNEE_LIMITS
    },
    LeftFoot = {
        "LeftLowerLeg",
        "LeftFoot",
        "LeftAnkleRigAttachment",
        v1.ANKLE_LIMITS
    },
    RightUpperLeg = {
        "LowerTorso",
        "RightUpperLeg",
        "RightHipRigAttachment",
        v1.HIP_LIMITS
    },
    RightLowerLeg = {
        "RightUpperLeg",
        "RightLowerLeg",
        "RightKneeRigAttachment",
        v1.KNEE_LIMITS
    },
    RightFoot = {
        "RightLowerLeg",
        "RightFoot",
        "RightAnkleRigAttachment",
        v1.ANKLE_LIMITS
    }
};
v1.R15_NO_COLLIDES = { { "LowerTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftHand" }, { "LowerTorso", "RightUpperArm" }, { "RightUpperArm", "RightHand" }, { "LeftUpperLeg", "RightUpperLeg" }, { "UpperTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightFoot" }, { "UpperTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftFoot" }, { "UpperTorso", "LeftLowerLeg" }, { "UpperTorso", "RightLowerLeg" }, { "LowerTorso", "LeftLowerLeg" }, { "LowerTorso", "RightLowerLeg" }, { "UpperTorso", "LeftLowerArm" }, { "UpperTorso", "RightLowerArm" }, { "Head", "LeftUpperArm" }, { "Head", "RightUpperArm" } };
v1.R15_MOTOR6DS = {
    RootPart = {},
    UpperTorso = { "Waist", "UpperTorso" },
    Head = { "Neck", "Head" },
    LeftUpperArm = { "LeftShoulder", "LeftUpperArm" },
    LeftLowerArm = { "LeftElbow", "LeftLowerArm" },
    LeftHand = { "LeftWrist", "LeftHand" },
    RightUpperArm = { "RightShoulder", "RightUpperArm" },
    RightLowerArm = { "RightElbow", "RightLowerArm" },
    RightHand = { "RightWrist", "RightHand" },
    LeftUpperLeg = { "LeftHip", "LeftUpperLeg" },
    LeftLowerLeg = { "LeftKnee", "LeftLowerLeg" },
    LeftFoot = { "LeftAnkle", "LeftFoot" },
    RightUpperLeg = { "RightHip", "RightUpperLeg" },
    RightLowerLeg = { "RightKnee", "RightLowerLeg" },
    RightFoot = { "RightAnkle", "RightFoot" }
};
v1.R6_ADDITIONAL_ATTACHMENTS = {
    { "Head", "NeckAttachment", CFrame.new(0, -0.5, 0) },
    { "Torso", "RightShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(1, 0.5, 0), v1.V3_RIGHT, v1.V3_UP) },
    { "Right Arm", "RightShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(-0.5, 0.5, 0), v1.V3_DOWN, v1.V3_RIGHT) },
    { "Torso", "LeftShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(-1, 0.5, 0), v1.V3_LEFT, v1.V3_UP) },
    { "Left Arm", "LeftShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(0.5, 0.5, 0), v1.V3_DOWN, v1.V3_LEFT) },
    { "Torso", "RightHipAttachment", CFrame.new(0.5, -1, 0) },
    { "Right Leg", "RightHipAttachment", CFrame.new(0, 1, 0) },
    { "Torso", "LeftHipAttachment", CFrame.new(-0.5, -1, 0) },
    { "Left Leg", "LeftHipAttachment", CFrame.new(0, 1, 0) }
};
v1.R6_RAGDOLL_RIG = {
    RootPart = {},
    Head = {
        "Torso",
        "Head",
        "NeckAttachment",
        v1.R6_HEAD_LIMITS
    },
    LeftLeg = {
        "Torso",
        "Left Leg",
        "LeftHipAttachment",
        v1.R6_HIP_LIMITS
    },
    RightLeg = {
        "Torso",
        "Right Leg",
        "RightHipAttachment",
        v1.R6_HIP_LIMITS
    },
    LeftArm = {
        "Torso",
        "Left Arm",
        "LeftShoulderRagdollAttachment",
        v1.R6_SHOULDER_LIMITS
    },
    RightArm = {
        "Torso",
        "Right Arm",
        "RightShoulderRagdollAttachment",
        v1.R6_SHOULDER_LIMITS
    }
};
v1.R6_NO_COLLIDES = { { "Left Leg", "Right Leg" }, { "Head", "Right Arm" }, { "Head", "Left Arm" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" } };
v1.R6_MOTOR6DS = {
    RootPart = {},
    Head = { "Neck", "Torso" },
    LeftArm = { "Left Shoulder", "Torso" },
    RightArm = { "Right Shoulder", "Torso" },
    LeftLeg = { "Left Hip", "Torso" },
    RightLeg = { "Right Hip", "Torso" }
};
v1.BALL_SOCKET_NAME = "RagdollBallSocket";
v1.NO_COLLIDE_NAME = "RagdollNoCollision";

return v1;