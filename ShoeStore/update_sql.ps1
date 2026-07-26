$sqlFile = "d:\PhucLHCE191132\SWP391\ProjectSWP391\ProjectSWP391\ShoeStore\ShoesStore_Project_INSERT_statement.sql"
$content = [System.IO.File]::ReadAllText($sqlFile, [System.Text.Encoding]::UTF8)

$idxProducts = $content.IndexOf("-- 6. Products")
$idxImports = $content.IndexOf("-- 9. Imports & Details")

if ($idxProducts -ge 0 -and $idxImports -ge 0) {
    $beforeProducts = $content.Substring(0, $idxProducts)
    $afterImports = $content.Substring($idxImports)

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("-- 6. Products")
    [void]$sb.AppendLine('INSERT INTO "products" ("id", "name", "description", "price", "category_id", "brand_id", "status") VALUES ')
    
    $brands = @('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD')
    $categories = @('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', '44444444-4444-4444-4444-444444444444')
    
    $productIds = @()
    $TOTAL = 250

    for ($i = 1; $i -le $TOTAL; $i++) {
        $idStr = "10000000-0000-0000-0000-000000000" + $i.ToString("D3")
        $productIds += $idStr
        
        $brand = $brands[$i % 4]
        $category = $categories[$i % 4]
        
        if ($i -eq 1) {
            $name = "Air Max Pulse"
            $desc = "Men''s running shoes with Air Max cushioning."
            $price = 160.00
        } elseif ($i -eq 2) {
            $name = "Ultraboost Light"
            $desc = "Lightweight and comfortable running shoes."
            $price = 190.00
        } elseif ($i -eq 3) {
            $name = "Puma MB.02"
            $desc = "LaMelo Ball signature basketball shoes."
            $price = 130.00
        } elseif ($i -eq 4) {
            $name = "Air Force 1 ''07"
            $desc = "Classic lifestyle fashion shoes."
            $price = 110.00
        } else {
            $name = "Dummy Product $i"
            $desc = "High quality sports and lifestyle shoes model $i."
            $price = 100.00 + ($i % 100)
        }
        
        $line = "('$idStr', '$name', '$desc', $price, '$category', '$brand', 'active')"
        if ($i -eq $TOTAL) {
            [void]$sb.AppendLine($line + ";")
        } else {
            [void]$sb.AppendLine($line + ",")
        }
    }
    
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("-- 7. Product Variants")
    [void]$sb.AppendLine('INSERT INTO "product_variants" ("id", "product_id", "size", "color", "stock_quantity", "created_at") VALUES')
    
    for ($i = 1; $i -le $TOTAL; $i++) {
        $idStr = $productIds[$i - 1]
        $color = if ($i % 2 -eq 0) { 'White' } else { 'Black' }
        $size = (39 + ($i % 5)).ToString()
        
        $line = "(NEWID(), '$idStr', '$size', '$color', 50, SYSDATETIMEOFFSET())"
        if ($i -eq $TOTAL) {
            [void]$sb.AppendLine($line + ";")
        } else {
            [void]$sb.AppendLine($line + ",")
        }
    }

    [void]$sb.AppendLine()
    [void]$sb.AppendLine("-- 8. Product Images")
    [void]$sb.AppendLine('INSERT INTO "product_images" ("id", "product_id", "image_url", "sort_order") VALUES ')
    
    for ($i = 1; $i -le $TOTAL; $i++) {
        $idStr = $productIds[$i - 1]
        
        $line = "(NEWID(), '$idStr', 'assets/fallback.png', 1)"
        if ($i -eq $TOTAL) {
            [void]$sb.AppendLine($line + ";")
        } else {
            [void]$sb.AppendLine($line + ",")
        }
    }

    [void]$sb.AppendLine()

    $newContent = $beforeProducts + $sb.ToString() + $afterImports
    [System.IO.File]::WriteAllText($sqlFile, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "Updated SQL file with $TOTAL products."
}
