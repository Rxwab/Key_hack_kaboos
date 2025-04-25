local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- إعدادات المفتاح
local KEY_PREFIX = "FREE_"
local SCRIPT_DURATION = 600 -- 10 دقائق
local keyActivated = false

-- رابط السكربت الثاني من GitHub
local SCRIPTS_UI_URL = "https://raw.githubusercontent.com/Rxwab/Hackkaboos_pro/refs/heads/main/Kabooshackpro.lua"

-- تصحيح: تأكيد تحميل السكربت
print("جاري تشغيل سكربت هاك كابوس...")

-- تخزين كلمات السر المؤقتة
local keyCache = {}

-- التحقق من كلمة السر
local function validateKey(key)
    if keyCache[key] then
        print("المفتاح موجود في الكاش: ", key)
        return true
    end
    if string.sub(key, 1, #KEY_PREFIX) == KEY_PREFIX then
        print("مفتاح صالح: ", key)
        keyCache[key] = true
        return true
    end
    print("مفتاح غير صالح: ", key)
    return false
end

-- إنشاء رابط مخصص لكل لاعب
local function generateCustomLink()
    local uniqueId = HttpService:GenerateGUID(false)
    local link = "https://rxwab.github.io/Kaboos_CodeGenerator/?user=" .. LocalPlayer.UserId .. "&id=" .. uniqueId
    print("تم إنشاء رابط: ", link)
    return link
end

-- السكربت الأول: واجهة إدخال المفتاح
local function createFirstScript()
    print("جاري إنشاء واجهة إدخال المفتاح...")
    
    -- إنشاء ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "KaboosHackUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    print("تم إنشاء ScreenGui")

    -- إنشاء Frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 200, 0, 200)
    Frame.Position = UDim2.new(0.5, -100, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    print("تم إنشاء Frame")

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame

    -- عنوان
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 5)
    Title.Text = "هاك كابوس"
    Title.TextColor3 = Color3.fromRGB(0, 255, 0)
    Title.TextScaled = true
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Frame
    print("تم إنشاء Title")

    -- زر نسخ الرابط
    local LinkButton = Instance.new("TextButton")
    LinkButton.Size = UDim2.new(0.8, 0, 0, 30)
    LinkButton.Position = UDim2.new(0.1, 0, 0, 40)
    LinkButton.Text = "نسخ الرابط"
    LinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LinkButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    LinkButton.TextScaled = true
    LinkButton.Font = Enum.Font.SourceSansBold
    LinkButton.Parent = Frame
    print("تم إنشاء LinkButton")

    local LinkCorner = Instance.new("UICorner")
    LinkCorner.CornerRadius = UDim.new(0, 8)
    LinkCorner.Parent = LinkButton

    -- إشعار النسخ
    local CopyNotification = Instance.new("TextLabel")
    CopyNotification.Size = UDim2.new(0.8, 0, 0, 20)
    CopyNotification.Position = UDim2.new(0.1, 0, 0, 75)
    CopyNotification.Text = ""
    CopyNotification.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyNotification.TextScaled = true
    CopyNotification.BackgroundTransparency = 1
    CopyNotification.Font = Enum.Font.SourceSans
    CopyNotification.Parent = Frame
    print("تم إنشاء CopyNotification")

    LinkButton.MouseButton1Click:Connect(function()
        pcall(function()
            local link = generateCustomLink()
            setclipboard(link)
            CopyNotification.Text = "تم النسخ!"
            print("تم نسخ الرابط")
            wait(2)
            CopyNotification.Text = ""
        end)
    end)

    -- مربع إدخال المفتاح
    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
    KeyInput.Position = UDim2.new(0.1, 0, 0, 100)
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "مفتاح (FREE_)"
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeyInput.TextScaled = true
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.Parent = Frame
    print("تم إنشاء KeyInput")

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 8)
    KeyInputCorner.Parent = KeyInput

    -- إشعار الخطأ
    local ErrorLabel = Instance.new("TextLabel")
    ErrorLabel.Size = UDim2.new(0.8, 0, 0, 20)
    ErrorLabel.Position = UDim2.new(0.1, 0, 0, 135)
    ErrorLabel.Text = ""
    ErrorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    ErrorLabel.TextScaled = true
    ErrorLabel.BackgroundTransparency = 1
    ErrorLabel.Font = Enum.Font.SourceSans
    ErrorLabel.Parent = Frame
    print("تم إنشاء ErrorLabel")

    -- زر التفعيل
    local ActivateButton = Instance.new("TextButton")
    ActivateButton.Size = UDim2.new(0.8, 0, 0, 30)
    ActivateButton.Position = UDim2.new(0.1, 0, 0, 160)
    ActivateButton.Text = "تفعيل"
    ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    ActivateButton.TextScaled = true
    ActivateButton.Font = Enum.Font.GothamBold
    ActivateButton.Parent = Frame
    print("تم إنشاء ActivateButton")

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ActivateButton

    ActivateButton.MouseButton1Click:Connect(function()
        local inputKey = KeyInput.Text
        if validateKey(inputKey) then
            print("تفعيل السكربت الثاني...")
            ScreenGui:Destroy() -- السكربت الأول يختفي
            local success, err = pcall(function()
                loadstring(game:HttpGet(SCRIPTS_UI_URL))()
            end)
            if success then
                print("تم تحميل السكربت الثاني بنجاح")
            else
                warn("فشل تحميل السكربت الثاني: ", err)
                local ErrorGui = Instance.new("ScreenGui")
                ErrorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
                local ErrorFrame = Instance.new("Frame")
                ErrorFrame.Size = UDim2.new(0, 200, 0, 100)
                ErrorFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
                ErrorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                ErrorFrame.Parent = ErrorGui
                local ErrorText = Instance.new("TextLabel")
                ErrorText.Size = UDim2.new(1, 0, 1, 0)
                ErrorText.Text = "خطأ: فشل تحميل السكربت!"
                ErrorText.TextColor3 = Color3.fromRGB(255, 0, 0)
                ErrorText.TextScaled = true
                ErrorText.BackgroundTransparency = 1
                ErrorText.Parent = ErrorFrame
                print("تم إنشاء واجهة الخطأ")
            end
        else
            ErrorLabel.Text = "مفتاح غلط!"
            print("تم عرض إشعار خطأ المفتاح")
            wait(2)
            ErrorLabel.Text = ""
        end
    end)
end

-- إدارة انتهاء الصلاحية
spawn(function()
    while true do
        if keyActivated then
            print("انتهاء صلاحية المفتاح بعد ", SCRIPT_DURATION, " ثانية")
            wait(SCRIPT_DURATION)
            keyActivated = false
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            for _, gui in ipairs(playerGui:GetChildren()) do
                if gui.Name == "ScriptsUI" or gui.Name == "CircleButtonUI" then
                    gui:Destroy()
                    print("تم إغلاق واجهات السكربت الثاني")
                end
            end
            createFirstScript()
        end
        wait(1)
    end
end)

-- تشغيل السكربت الأول
print("تشغيل السكربت الأول...")
createFirstScript()
