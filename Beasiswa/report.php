<div class="card">
  <div class="card-header bg-primary text-white border-dark"><strong>Perangkingan</strong></div>
  <div class="card-body">
<!--form memilih tahun dan tombol proses-->
  <form action="preview.php" target="_blank" method="POST">
  <div class="form-group">
   <label for="">Tahun</label>
   <select class="form-control chosen" data-placeholder="Pilih Tahun" name="tahun">
<option value=""></option>;
<?php
for ($x=date("Y");$x>=2015;$x--){
?>
<option value="<?php echo $x; ?>"><?php echo $x; ?></option>
<?php
}
?>
</select>
   </div>
   <input class="btn btn-primary mb-3" type="submit" name="cetak" value="Cetak">
</form>