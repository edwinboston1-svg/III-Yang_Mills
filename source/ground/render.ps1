param([string]$InDocx, [string]$OutPdf, [string]$OutDocx = "")
# Open a .docx in Word, update the table of contents and every field, save a PDF (and optionally the updated .docx).
$ErrorActionPreference = "Stop"
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
try {
  $doc = $word.Documents.Open($InDocx, $false, $false)
  foreach ($toc in $doc.TablesOfContents) { $toc.Update() }
  $doc.Fields.Update() | Out-Null
  foreach ($toc in $doc.TablesOfContents) { $toc.Update() }
  if ($OutDocx -ne "") { $doc.SaveAs2($OutDocx, 16) }
  $doc.SaveAs2($OutPdf, 17)
  $pages = $doc.ComputeStatistics(2)
  Write-Output "pages=$pages"
  $doc.Close($false)
} finally {
  $word.Quit()
  [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}
