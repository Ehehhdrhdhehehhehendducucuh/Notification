return function(title, message, duration, imageId)
    local TweenService = game:GetService("TweenService")

    -- Create UI
    local ScreenGui = Instance.new("ScreenGui")
    local NotificationFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local ImageLabel = Instance.new("ImageLabel")
    local TitleLabel = Instance.new("TextLabel")
    local MessageLabel = Instance.new("TextLabel")

    -- Parent UI to Player's GUI
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Notification Frame
    NotificationFrame.Parent = ScreenGui
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    NotificationFrame.Position = UDim2.new(0.5, 0, 1, 100) -- Start off-screen
    NotificationFrame.Size = UDim2.new(0.8, 0, 0.15, 0) -- Scaled for mobile (80% width, 15% height)
    NotificationFrame.AnchorPoint = Vector2.new(0.5, 1)

    -- UICorner for rounded edges
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = NotificationFrame

    -- UIStroke for border effect
    UIStroke.Parent = NotificationFrame
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(80, 80, 80)

    -- ImageLabel (for icons or thumbnails)
    ImageLabel.Parent = NotificationFrame
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.05, 0, 0.5, -32) -- Position based on frame size
    ImageLabel.Size = UDim2.new(0.2, 0, 0.8, 0) -- Scaled size
    ImageLabel.Image = imageId or "rbxassetid://0" -- Replace with a valid image ID
    ImageLabel.ScaleType = Enum.ScaleType.Fit

    -- Title Label
    TitleLabel.Parent = NotificationFrame
    TitleLabel.Text = title or "Notification"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.FredokaOne
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0.3, 0, 0.1, 0)
    TitleLabel.Size = UDim2.new(0.65, 0, 0.3, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Message Label
    MessageLabel.Parent = NotificationFrame
    MessageLabel.Text = message or "This is the message content."
    MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageLabel.Font = Enum.Font.FredokaOne
    MessageLabel.TextSize = 14
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Position = UDim2.new(0.3, 0, 0.4, 0)
    MessageLabel.Size = UDim2.new(0.65, 0, 0.5, 0)
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextWrapped = true

    -- Slide-in animation
    local slideIn = TweenService:Create(
        NotificationFrame,
        TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0.9, 0)} -- Position for mobile near the bottom
    )
    slideIn:Play()

    -- Subtle scale-in effect
    local scaleIn = TweenService:Create(
        NotificationFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0.82, 0, 0.16, 0)} -- Slight enlargement for effect
    )
    scaleIn:Play()

    -- Auto-remove with slide-out and fade
    task.delay(duration or 4, function()
        -- Slide-out animation
        local slideOut = TweenService:Create(
            NotificationFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, 0, 1, 100)} -- Slide off-screen
        )
        slideOut:Play()

        -- Fade-out animation
        local fadeOut = TweenService:Create(
            NotificationFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        )
        fadeOut:Play()

        slideOut.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
end
