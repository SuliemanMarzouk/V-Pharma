<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="admin/css/sb-admin-2.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
    @include('pharmacy/navbar')

          <!-- Begin Page Content -->
        <div class="container-fluid">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">List Warehouse</h1>
            </div>

            <br><br>

            <div class="container">
                @foreach ($warehouses as $warehouse)
                @if ($warehouse->status == 1)
                <a href="/warehouse/{{ $warehouse->ID }}" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">{{ $warehouse->WHName }}</h5>
                            <p class="card-text">Address: {{ $warehouse->Address }}</p>
                            <p class="card-text">Phone: {{ $warehouse->PhoneNum }}</p>
                            <div class="status-indicator">
                                    <i class="fas fa-circle text-success">Online</i>
                @else
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">{{ $warehouse->WHName }}</h5>
                            <p class="card-text">Address: {{ $warehouse->Address }}</p>
                            <p class="card-text">Phone: {{ $warehouse->PhoneNum }}</p>
                            <div class="status-indicator">
                                    <i class="fas fa-circle text-danger">Offline</i>
                                @endif
                            </div>
                        </div>
                    </div>
                </a>
                @endforeach
            </div>
        </div>
        <!-- End of Main Content -->
        
    </div>
    <!-- End of Content Wrapper -->
    
    @include('admin/footer')
</div>
</div>
    <!-- Footer -->

    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="admin/vendor/jquery/jquery.min.js"></script>
    <script src="admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="admin/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="admin/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="admin/js/demo/chart-area-demo.js"></script>
    <script src="admin/js/demo/chart-pie-demo.js"></script>

</body>

