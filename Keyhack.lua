-- سكربت واجهة إدخال المفتاح الفاخرة
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- دالة لإنشاء أنيميشن الخط المتحرك
local function createBorderAnimation(parent, borderColor)
    local Border = Instance.new("Frame")
    Border.Size = UDim2.new(1, 4, 1, 4)
    Border.Position = UDim2.new(0, -2, 0, -2)
    Border.BackgroundTransparency = 1
    Border.Parent = parent

    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(0, 0, 0, 4)
    Top.Position = UDim2.new(0, 0, 0, -2)
    Top.BackgroundColor3 = borderColor
    Top.Parent = Border

    local Bottom = Instance.new("Frame")
    Bottom.Size = UDim2.new(0, 0, 0, 4)
    Bottom.Position = UDim2.new(1, 0, 1, -2)
    Bottom.BackgroundColor3 = borderColor
    Bottom.Parent = Border

    local Left = Instance.new("Frame")
    Left.Size = UDim2.new(0, 4, 0, 0)
    Left.Position = UDim2.new(0, -2, 0, 0)
    Left.BackgroundColor3 = borderColor
    Left.Parent = Border

    local Right = Instance.new("Frame")
    Right.Size = UDim2.new(0, 4, 0, 0)
    Right.Position = UDim2.new(1, -2, 1, 0)
    Right.BackgroundColor3 = borderColor
    Right.Parent = Border

    local function animateBorder()
        while true do
            TweenService:Create(Top, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 0, 4)}):Play()
            wait(1)
            TweenService:Create(Right, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 4, 1, 0)}):Play()
            wait(1)
            TweenService:Create(Bottom, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 0, 4), Position = UDim2.new(0, 0, 1, -2)}):Play()
            wait(1)
            TweenService:Create(Left, TweenInfo.new(1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 4, 1, 0)}):Play()
            wait(1)
            TweenService:Create(Top, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 0, 0, 4)}):Play()
            TweenService:Create(Right, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 4, 0, 0)}):Play()
            TweenService:Create(Bottom, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 0, 0, 4)}):Play()
            TweenService:Create(Left, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 4, 0, 0)}):Play()
            wait(0.5)
        end
    end
    spawn(animateBorder)
end

-- دالة لإنشاء واجهة إدخال المفتاح
local function createKeyInput()
    print("Creating KeyInput UI")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = PlayerGui
    ScreenGui.Name = "KeyInputUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 350, 0, 250)
    Frame.Position = UDim2.new(0.5, -175, 0.5, -125)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = ScreenGui
    Frame.Visible = true

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
    })
    Gradient.Parent = Frame

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 12)
    FrameCorner.Parent = Frame

    createBorderAnimation(Frame, Color3.fromRGB(255, 0, 0))

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "أدخل المفتاح الفاخر"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextScaled = true
    Title.BackgroundTransparency = 1
    Title.TextStrokeTransparency = 0.8
    Title.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    Title.Parent = Frame

    local WebsiteButton = Instance.new("TextButton")
    WebsiteButton.Size = UDim2.new(0.8, 0, 0, 30)
    WebsiteButton.Position = UDim2.new(0.1, 0, 0.15, 0)
    WebsiteButton.Text = "انسخ رابط الموقع"
    WebsiteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    WebsiteButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    WebsiteButton.Font = Enum.Font.Gotham
    WebsiteButton.TextScaled = true
    WebsiteButton.Parent = Frame

    local WebsiteButtonCorner = Instance.new("UICorner")
    WebsiteButtonCorner.CornerRadius = UDim.new(0, 8)
    WebsiteButtonCorner.Parent = WebsiteButton

    WebsiteButton.MouseEnter:Connect(function()
        TweenService:Create(WebsiteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    WebsiteButton.MouseLeave:Connect(function()
        TweenService:Create(WebsiteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 255)}):Play()
    end)

    local YoutubeButton = Instance.new("TextButton")
    YoutubeButton.Size = UDim2.new(0.8, 0, 0, 30)
    YoutubeButton.Position = UDim2.new(0.1, 0, 0.25, 0)
    YoutubeButton.Text = "انسخ رابط قناة يوتيوب"
    YoutubeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    YoutubeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    YoutubeButton.Font = Enum.Font.Gotham
    YoutubeButton.TextScaled = true
    YoutubeButton.Parent = Frame

    local YoutubeButtonCorner = Instance.new("UICorner")
    YoutubeButtonCorner.CornerRadius = UDim.new(0, 8)
    YoutubeButtonCorner.Parent = YoutubeButton

    YoutubeButton.MouseEnter:Connect(function()
        TweenService:Create(YoutubeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)
    YoutubeButton.MouseLeave:Connect(function()
        TweenService:Create(YoutubeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
    end)

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
    KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextScaled = true
    KeyInput.PlaceholderText = "اكتب المفتاح (يبدأ بـ FREE_)"
    KeyInput.Parent = Frame

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 8)
    KeyInputCorner.Parent = KeyInput

    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(0.8, 0, 0, 40)
    SubmitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    SubmitButton.Text = "تأكيد"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.TextScaled = true
    SubmitButton.Parent = Frame

    local SubmitButtonCorner = Instance.new("UICorner")
    SubmitButtonCorner.CornerRadius = UDim.new(0, 8)
    SubmitButtonCorner.Parent = SubmitButton

    SubmitButton.MouseEnter:Connect(function()
        TweenService:Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}):Play()
    end)
    SubmitButton.MouseLeave:Connect(function()
        TweenService:Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}):Play()
    end)

    WebsiteButton.MouseButton1Click:Connect(function()
        local url = "https://rxwab.github.io/Kaboos_CodeGenerator/?user=ym80eglpqj"
        pcall(function()
            setclipboard(url)
            game.StarterGui:SetCore("SendNotification", {
                Title = "تم النسخ",
                Text = "رابط الموقع تم نسخه إلى الحافظة",
                Duration = 3
            })
        end)
    end)

    YoutubeButton.MouseButton1Click:Connect(function()
        local url = "https://www.youtube.com/@RX_MAR"
        pcall(function()
            setclipboard(url)
            game.StarterGui:SetCore("SendNotification", {
                Title = "تم النسخ",
                Text = "رابط قناة يوتيوب تم نسخه إلى الحافظة",
                Duration = 3
            })
        end)
    end)

    SubmitButton.MouseButton1Click:Connect(function()
        print("Submit Button Clicked")
        local enteredKey = KeyInput.Text
        if enteredKey:match("^FREE_") then
            print("Valid Key Entered")
            ScreenGui:Destroy()
            wait(0.2)
            local success, errorMsg = pcall(function()
                -- استبدل الرابط برابط السكربت الثاني على GitHub
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Rxwab/Hackkaboos_pro/main/Kabooshackpro.lua"))()
            end)
            if success then
                print("Main Menu Loaded Successfully")
                game.StarterGui:SetCore("SendNotification", {
                    Title = "نجاح",
                    Text = "المفتاح صحيح، القايمة الفاخرة ظهرت",
                    Duration = 3
                })
            else
                print("Failed to Load Main Menu: " .. tostring(errorMsg))
                game.StarterGui:SetCore("SendNotification", {
                    Title = "خطأ",
                    Text = "فشل في تحميل القايمة: " .. tostring(errorMsg),
                    Duration = 5
                })
            end
        else
            print("Invalid Key Entered")
            KeyInput.Text = ""
            KeyInput.PlaceholderText = "مفتاح خاطئ، حاول مرة أخرى (يبدأ بـ FREE_)"
        end)
    end)
end

-- بدء السكربت
createKeyInput()
