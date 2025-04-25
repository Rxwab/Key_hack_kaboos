local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- إعدادات المفتاح
local KEY_PREFIX = "FREE_"
local SCRIPT_DURATION = 600 -- 10 دقائق
local keyActivated = false
local scriptExpired = false

-- رابط القائمة الثانية (ScriptsUI.lua) من GitHub
local SCRIPTS_UI_URL = "https://raw.githubusercontent.com/YourUsername/Kaboos-ScriptsUI/main/ScriptsUI.lua" -- استبدل بالرابط الحقيقي

-- تخزين كلمات السر المؤقتة
local keyCache = {}

-- التحقق من كلمة السر
local function validateKey(key)
    if keyCache[key] then
        return true
    end
    if string.sub(key, 1, #KEY_PREFIX) == KEY_PREFIX then
        keyCache[key] = true
        return true
    end
    return false
end

-- إنشاء رابط مخصص لكل لاعب
local function generateCustomLink()
    local uniqueId = HttpService:GenerateGUID(false)
    return "https://rxwab.github.io/Kaboos_CodeGenerator/?user=" .. LocalPlayer.UserId .. "&id=" .. uniqueId
end

-- واجهة تسجيل المفتاح
local function createFirstUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "KaboosHackUI"
    ScreenGui.ResetOnSpawn = false

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.7
    Background.Parent = ScreenGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 450, 0, 400)
    Frame.Position = UDim2.new(0.5, -225, 0.5, -200)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BackgroundTransparency = 0.1
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = Frame

    -- عنوان متحرك
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.Position = UDim2.new(0, 0, 0, 20)
    Title.Text = "💀 هاك كابوس الأسطوري 💀"
    Title.TextColor3 = Color3.fromRGB(0, 255, 0)
    Title.TextScaled = true
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBlack
    Title.Parent = Frame

    local function animateTitle()
        local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
        local tween = TweenService:Create(Title, tweenInfo, {TextTransparency = 0.3})
        tween:Play()
    end
    animateTitle()

    -- نص الرابط المخصص
    local LinkLabel = Instance.new("TextLabel")
    LinkLabel.Size = UDim2.new(0.9, 0, 0, 40)
    LinkLabel.Position = UDim2.new(0.05, 0, 0, 90)
    LinkLabel.Text = "انقر لنسخ رابط مفتاحك الخاص 🔗"
    LinkLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    LinkLabel.TextScaled = true
    LinkLabel.BackgroundTransparency = 1
    LinkLabel.Font = Enum.Font.SourceSansBold
    LinkLabel.Parent = Frame

    local LinkGlow = Instance.new("UIStroke")
    LinkGlow.Thickness = 2
    LinkGlow.Color = Color3.fromRGB(0, 255, 0)
    LinkGlow.Parent = LinkLabel

    -- إشعار النسخ
    local CopyNotification = Instance.new("TextLabel")
    Bahrain.Size = UDim2.new(0.9, 0, 0, 30)
    CopyNotification.Position = UDim2.new(0.05, 0, 0, 130)
    CopyNotification.Text = ""
    CopyNotification.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyNotification.TextScaled = true
    CopyNotification.BackgroundTransparency = 1
    CopyNotification.Font = Enum.Font.SourceSans
    CopyNotification.Parent = Frame

    LinkLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local link = generateCustomLink()
            setclipboard(link)
            CopyNotification.Text = "تم نسخ رابط المفتاح!"
            wait(2)
            CopyNotification.Text = ""
        end
    end)

    -- مربع إدخال المفتاح
    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(0.8, 0, 0, 50)
    KeyInput.Position = UDim2.new(0.1, 0, 0, 170)
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "أدخل مفتاحك (يبدأ بـ FREE_)"
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeyInput.TextScaled = true
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.Parent = Frame

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 12)
    KeyInputCorner.Parent = KeyInput

    -- إشعار الخطأ
    local ErrorLabel = Instance.new("TextLabel")
    ErrorLabel.Size = UDim2.new(0.9, 0, 0, 30)
    ErrorLabel.Position = UDim2.new(0.05, 0, 0, 230)
    ErrorLabel.Text = ""
    ErrorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    ErrorLabel.TextScaled = true
    ErrorLabel.BackgroundTransparency = 1
    ErrorLabel.Font = Enum.Font.SourceSans
    ErrorLabel.Parent = Frame

    -- زر التفعيل
    local ActivateButton = Instance.new("TextButton")
    ActivateButton.Size = UDim2.new(0.8, 0, 0, 60)
    ActivateButton.Position = UDim2.new(0.1, 0, 0, 270)
    ActivateButton.Text = "تفعيل الهاك [ ]"
    ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    ActivateButton.TextScaled = true
    ActivateButton.Font = Enum.Font.GothamBold
    ActivateButton.Parent = Frame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = ActivateButton

    ActivateButton.MouseButton1Click:Connect(function()
        local inputKey = KeyInput.Text
        if validateKey(inputKey) then
            keyActivated = true
            ActivateButton.Text = "تفعيل الهاك [✅]"
            ScreenGui:Destroy()
            -- تحميل وتنفيذ القائمة الثانية من GitHub
            local success, err = pcall(function()
                loadstring(game:HttpGet(SCRIPTS_UI_URL))()
            end)
            if not success then
                warn("فشل تحميل القائمة الثانية:", err)
                local ErrorGui = Instance.new("ScreenGui")
                ErrorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
                local ErrorFrame = Instance.new("Frame")
                ErrorFrame.Size = UDim2.new(0, 300, 0, 150)
                ErrorFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
                ErrorFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                ErrorFrame.Parent = ErrorGui
                local ErrorText = Instance.new("TextLabel")
                ErrorText.Size = UDim2.new(1, 0, 1, 0)
                ErrorText.Text = "فشل تحميل القائمة! تحقق من الرابط."
                ErrorText.TextColor3 = Color3.fromRGB(255, 0, 0)
                ErrorText.TextScaled = true
                ErrorText.BackgroundTransparency = 1
                ErrorText.Parent = ErrorFrame
            end
        else
            ActivateButton.Text = "تفعيل الهاك [❌]"
            ErrorLabel.Text = "مفتاح غير صالح! حاول مرة أخرى."
            wait(2)
            ErrorLabel.Text = ""
        end
    end)
end

-- إدارة انتهاء صلاحية المفتاح
spawn(function()
    while true do
        if keyActivated then
            wait(SCRIPT_DURATION)
            scriptExpired = true
            keyActivated = false
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            for _, gui in ipairs(playerGui:GetChildren()) do
                if gui.Name == "ScriptsUI" or gui.Name == "CircleButtonUI" then
                    gui:Destroy()
                end
            end
            createFirstUI()
        end
        wait(1)
    end
end)

-- تشغيل السكربت
createFirstUI()
