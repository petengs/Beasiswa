<!-- proses update data -->
<?php 

if(isset($_POST['update'])){
    
    // ambil data dari masing" input
    $nim=$_POST['nim'];
    $nama=$_POST['nama'];
    $alamat=$_POST['alamat'];
    $telp=$_POST['telp'];

    // proses update
    $sql = "UPDATE mahasiswa SET nama_mahasiswa='$nama',alamat='$alamat',telp='$telp' WHERE nim='$nim'";
    if ($conn->query($sql) === TRUE) {
        header("Location:?page=mahasiswa");
    }
}

// memanggil data dan memasukkan ke masing masing input
$nim=$_GET['nim'];

$sql = "SELECT * FROM mahasiswa WHERE nim='$nim'";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
?>

<!--tampilan update-->
<div class="row">
<div class="col-sm-12">
<form action="" method="POST">
<div class="card border-dark">
<div class="card">
<div class="card-header bg-primary text-white border-dark"><strong>UPDATE DATA MAHASISWA</strong></div>
	<div class="card-body">

    <div class="form-group">
   <label for="">NIM</label>
   <input type="text" class="form-control" value="<?php echo $row["nim"]?>" name="nim" readonly>
   </div>
   <div class="form-group">
   <label for="">Nama Mahasiswa</label>
   <input type="text" class="form-control" value="<?php echo $row["nama_mahasiswa"]?>" name="nama" maxlength="100" required>
   </div>
   <div class="form-group">
   <label for="">Alamat</label>
   <input type="text" class="form-control" value="<?php echo $row["alamat"]?>" name="alamat" maxlength="100" required>
   </div>
   <div class="form-group">
   <label for="">No. Telepon</label>
   <input type="text" class="form-control" value="<?php echo $row["telp"]?>" name="telp" maxlength="15" required>
   </div>


   <input class="btn btn-primary" type="submit" name="update" value="Update">
   <a class="btn btn-danger" href="?page=NAMA_PAGE">Batal</a>

</div>
</div>
</form>
</div>
</div>