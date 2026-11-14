$ErrorActionPreference = "SilentlyContinue"
$mysql = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
$outFile = "C:\Users\Aaron Carballo\Documents\Proyecto predeterminado\Practica03\07_verificacion\09_pruebas_acceso.txt"
$utf8 = New-Object System.Text.UTF8Encoding($false)

$lines = New-Object System.Collections.Generic.List[string]
function Run-Test {
    param(
        [string]$Title,
        [string]$Cnf,
        [string]$Sql,
        [string]$Expected
    )
    $tmpOut = [System.IO.Path]::GetTempFileName()
    $tmpErr = [System.IO.Path]::GetTempFileName()
    $argLine = "--defaults-file=`"$Cnf`" -e `"$Sql`""
    $proc = Start-Process -FilePath $mysql -ArgumentList $argLine -NoNewWindow -Wait -PassThru `
        -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr
    $code = $proc.ExitCode
    $out = (Get-Content -Path $tmpOut -Raw -Encoding UTF8)
    $err = (Get-Content -Path $tmpErr -Raw -Encoding UTF8)
    Remove-Item $tmpOut, $tmpErr -Force

    $lines.Add("============================================================")
    $lines.Add("PRUEBA: $Title")
    $lines.Add("Usuario: $((Get-Content $Cnf | Select-String '^user=').Line -replace '^user=','')")
    $lines.Add("SQL: $Sql")
    $lines.Add("Resultado esperado: $Expected")
    $lines.Add("------------------------------------------------------------")
    $body = ""
    if (-not [string]::IsNullOrWhiteSpace($out)) { $body += $out }
    if (-not [string]::IsNullOrWhiteSpace($err)) { $body += $err }
    if ([string]::IsNullOrWhiteSpace($body)) {
        $lines.Add("(sin filas devueltas)")
    } else {
        foreach ($ln in ($body -split "`r?`n")) {
            if ($ln.Trim() -ne "") { $lines.Add($ln.TrimEnd()) }
        }
    }
    $lines.Add("Codigo de salida: $code  ->  $(if ($code -eq 0) {'PERMITIDO / OK'} else {'DENEGADO / ERROR'})")
    $lines.Add("")
}

# ---------------- guest1 (user_not_registered) ----------------
Run-Test "Invitado consulta catalogo de productos" "C:\Users\Public\my_guest1.cnf" "SELECT COUNT(*) AS productos FROM db_test.tb_products;" "Permitido"
Run-Test "Invitado consulta vista de catalogo" "C:\Users\Public\my_guest1.cnf" "SELECT COUNT(*) AS categorias FROM db_test.vw_productos_por_categoria;" "Permitido"
Run-Test "Invitado intenta leer usuarios" "C:\Users\Public\my_guest1.cnf" "SELECT COUNT(*) FROM db_test.tb_users;" "Denegado"
Run-Test "Invitado intenta leer vista de trazabilidad de usuarios" "C:\Users\Public\my_guest1.cnf" "SELECT COUNT(*) FROM db_test.vw_trazabilidad_usuarios;" "Denegado"

# ---------------- buyer1 ----------------
Run-Test "Comprador consulta productos" "C:\Users\Public\my_buyer1.cnf" "SELECT COUNT(*) AS productos FROM db_test.tb_products;" "Permitido"
Run-Test "Comprador consulta carritos" "C:\Users\Public\my_buyer1.cnf" "SELECT COUNT(*) AS carritos FROM db_test.tb_carts;" "Permitido"
Run-Test "Comprador intenta leer bitacora" "C:\Users\Public\my_buyer1.cnf" "SELECT COUNT(*) FROM db_test.tb_logs;" "Denegado"
Run-Test "Comprador intenta leer vista de trazabilidad" "C:\Users\Public\my_buyer1.cnf" "SELECT COUNT(*) FROM db_test.vw_trazabilidad_productos;" "Denegado"

# ---------------- seller1 ----------------
Run-Test "Vendedor consulta sus productos" "C:\Users\Public\my_seller1.cnf" "SELECT COUNT(*) AS productos FROM db_test.tb_products;" "Permitido"
Run-Test "Vendedor consulta trazabilidad de productos" "C:\Users\Public\my_seller1.cnf" "SELECT COUNT(*) AS eventos FROM db_test.vw_trazabilidad_productos;" "Permitido"
Run-Test "Vendedor intenta leer pedidos" "C:\Users\Public\my_seller1.cnf" "SELECT COUNT(*) FROM db_test.tb_orders;" "Denegado"
Run-Test "Vendedor intenta eliminar un producto" "C:\Users\Public\my_seller1.cnf" "DELETE FROM db_test.tb_products WHERE 1=0;" "Denegado"
Run-Test "Vendedor intenta leer trazabilidad de usuarios" "C:\Users\Public\my_seller1.cnf" "SELECT COUNT(*) FROM db_test.vw_trazabilidad_usuarios;" "Denegado"

# ---------------- support ----------------
Run-Test "Soporte consulta vista de trazabilidad de usuarios" "C:\Users\Public\my_support.cnf" "SELECT COUNT(*) AS usuarios FROM db_test.vw_trazabilidad_usuarios;" "Permitido"
Run-Test "Soporte consulta bitacora" "C:\Users\Public\my_support.cnf" "SELECT COUNT(*) AS eventos FROM db_test.tb_logs;" "Permitido"
Run-Test "Soporte intenta eliminar productos" "C:\Users\Public\my_support.cnf" "DELETE FROM db_test.tb_products WHERE 1=0;" "Denegado"
Run-Test "Soporte intenta crear una tabla" "C:\Users\Public\my_support.cnf" "CREATE TABLE db_test.zz_permiso_support (id INT);" "Denegado"
Run-Test "Soporte intenta crear un usuario" "C:\Users\Public\my_support.cnf" "CREATE USER 'zz_invalido'@'%' IDENTIFIED BY 'x';" "Denegado"

# ---------------- admin ----------------
Run-Test "Administrador consulta vista de trazabilidad de usuarios" "C:\Users\Public\my_admin.cnf" "SELECT COUNT(*) AS usuarios FROM db_test.vw_trazabilidad_usuarios;" "Permitido"
Run-Test "Administrador actualiza productos (0 filas)" "C:\Users\Public\my_admin.cnf" "UPDATE db_test.tb_products SET name = name WHERE 1=0;" "Permitido"
Run-Test "Administrador intenta crear una tabla" "C:\Users\Public\my_admin.cnf" "CREATE TABLE db_test.zz_permiso_admin (id INT);" "Denegado"

# ---------------- superadmin ----------------
Run-Test "Superadministrador crea y elimina una tabla" "C:\Users\Public\my_superadmin.cnf" "CREATE TABLE db_test.zz_permiso_superadmin (id INT); DROP TABLE db_test.zz_permiso_superadmin;" "Permitido"

[System.IO.File]::WriteAllLines($outFile, $lines, $utf8)
Write-Output "Archivo generado: $outFile"
