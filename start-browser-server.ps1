# Добавяме цветове и стил
$host.UI.RawUI.WindowTitle = "Browser Tools Server - Toggle"
Clear-Host

function Write-ColoredText {
    param($text, $color)
    Write-Host $text -ForegroundColor $color
}

Write-ColoredText "==================================" "Cyan"
Write-ColoredText "    Browser Tools Server Toggle   " "Magenta"
Write-ColoredText "==================================" "Cyan"
Write-Host ""

# Проверка на порта
$serverPort = 3025
$processName = "node"

function Test-PortInUse {
    param($port)
    $connection = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue
    return $connection.TcpTestSucceeded
}

# Проверяваме текущия статус
if (Test-PortInUse $serverPort) {
    # Сървърът работи - ще го спрем
    Write-ColoredText "Спиране на сървъра..." "Yellow"
    Stop-Process -Name $processName -Force
    Write-ColoredText "Статус: НЕАКТИВЕН" "Red"
} else {
    # Сървърът не работи - ще го стартираме
    Write-ColoredText "Стартиране на сървъра..." "Cyan"
    
    # Стартираме сървъра
    cd "C:\Users\Georgi Markov\Documents\GitHub\Old\browser-tools-mcp\browser-tools-server"
    tsc && node dist/browser-connector.js
}

Write-Host ""
Write-ColoredText "Операцията завърши. Прозорецът ще се затвори след 3 секунди..." "Gray"
Start-Sleep -Seconds 3