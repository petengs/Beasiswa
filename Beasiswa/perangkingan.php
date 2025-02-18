<!--proses perangkingan-->
<?php

//mengambil data tahun dari input
// $tahun=$_POST['tahun'];

if(isset($_POST['proses'])){
    //mengambil data tahun dari input
    $tahun=$_POST['tahun'];

    //mengambil data dari tabel pendaftaran
    $sql = "SELECT*FROM pendaftaran WHERE tahun=$tahun";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        
        //menacari nilai max dan min
        $sql = "SELECT min(pendapatan_ortu) as mpendapatan, max(ipk) as mipk, max(jml_saudara) as msaudara FROM pendaftaran WHERE tahun=$tahun";
        $result = $conn->query($sql);
        $row = $result->fetch_assoc();

        $mpendapatan=$row["mpendapatan"];
        $mipk=$row["mipk"];
        $msaudara=$row["msaudara"];

        //proses normalisasi
        $sql = "SELECT*FROM pendaftaran WHERE tahun=$tahun";
        $result = $conn->query($sql);
        while($row = $result->fetch_assoc()) {

        //mengambil data pendaftaran 
        $iddaftar=$row["iddaftar"];
        $pendapatan=$row["pendapatan_ortu"];
        $ipk=$row["ipk"];
        $saudara=$row["jml_saudara"];

        // menghapus data perangkingan yang  lama
        $sql = "DELETE FROM perangkingan WHERE iddaftar='$iddaftar'";
        $conn->query($sql);

        //hitung normalisasi
        $npendapatan = $pendapatan / $mpendapatan;
        $nipk = $ipk / $mipk;
        $nsaudara = $saudara / $msaudara;

        //hitung nilai preferensi
        $preferensi = ($npendapatan*0.5)+($nipk*0.3)+($nsaudara*0.2);

        //simpan data perangkingan
        $sql = "INSERT INTO perangkingan VALUES (Null,'$iddaftar','$npendapatan','$nipk','$nsaudara','$preferensi')";
        if ($conn->query($sql) === TRUE) {
            header("Location:?page=perangkingan&thn=$tahun");
        }
     }

    }else{
        ?>
            <div class="alert alert-danger alert-dismissible fade show">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Data tidak ditemukan</strong>
            </div>
        <?php
    }
}
?>

<div class="card">
  <div class="card-header bg-primary text-white border-dark"><strong>Perangkingan</strong></div>
  <div class="card-body">
<!--form memilih tahun dan tombol proses-->
  <form action="" method="POST">
  <div class="form-group">
   <label for="">Tahun</label>
   <select class="form-control chosen" data-placeholder="Pilih Tahun" name="tahun">
<option value="<?= $_GET['thn']; ?>"><?= $_GET['thn']; ?></option>;
<?php
for ($x=date("Y");$x>=2015;$x--){
?>
<option value="<?php echo $x; ?>"><?php echo $x; ?></option>
<?php
}
?>
</select>
   </div>
   <input class="btn btn-primary mb-3" type="submit" name="proses" value="Proses">
</form>

<table class="table table-bordered" id="myTable">
    <thead>
      <tr>
        <th width="50">No.</th>
        <th width="100">NIM</th>
        <th width="200px">Nama Mahasiswa</th>
        <th width="300px">n_Pendapatan</th> 
        <th width="100px">n_IPK</th>
        <th width="100px">n_Saudara</th>
        <th width="80px">Preferensi</th>
        <th width="80px">tahun</th>
      </tr>
      <!--n_ = normalisasi-->
    </thead>
    <tbody>
        
			<!-- proses menampilkan data -->
    <?php
    $i=1;
     $sql = "SELECT*FROM vperangkingan ORDER BY preferensi DESC";
     //$sql = "SELECT perangkingan.idperangkingan,pendaftaran.iddaftar,pendaftaran.tgldaftar,pendaftaran.tahun,pendaftaran.nim,mahasiswa.nama_mahasiswa,perangkingan.n_pendapatan,perangkingan.n_ipk,perangkingan.n_saudara,perangkingan.preferensi
     //FROM perangkingan INNER JOIN pendaftaran ON perangkingan.iddaftar=pendaftaran.iddaftar INNER JOIN mahasiswa ON pendaftaran.nim=mahasiswa.nim ORDER BY idperangkingan ASC, preferensi DESC, tahun DESC";
     $result = $conn->query($sql);
     while($row = $result->fetch_assoc()) {
 ?>
     <tr>
    <td><?php echo $i++; ?></td>
    <td><?php echo $row['nim']; ?></td>
	<td><?php echo $row['nama_mahasiswa']; ?></td>
	<td><?php echo $row['n_pendapatan']; ?></td>
    <td><?php echo $row['n_ipk']; ?></td>
    <td><?php echo $row['n_saudara']; ?></td>
    <td><?php echo $row['preferensi']; ?></td>
    <td><?php echo $row['tahun']; ?></td>
     </tr>
 <?php
     }
     $conn->close();
 ?>
   </tbody>
</table>