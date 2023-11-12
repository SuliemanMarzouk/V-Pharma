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
    <link href="admin/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
        @include('admin/navbar')


    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Order</h1>
        </div>
        @if($customerOrders && !$customerOrders->isEmpty())
            @foreach($customerOrders as $customerOrder)
            <div class="card my-4">
                <div class="card-body">
                    <h5 class="card-title">Order #{{ $customerOrder->OrderNum }}</h5>
                    <p class="card-text">Customer: {{ $customerOrder->customer->FullName }}</p>
                    <p class="card-text">Phone Number: {{ $customerOrder->customer->PhoneNum }}</p>
                    <p class="card-text">Order Total: SYP {{ $customerOrder->TotalPrice }}</p>
                    @include('admin/modals/deliveryModal')
                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#deliveryCustomerModal{{ $customerOrder->ID }}">Accept</button>
                        <button type="button" class="btn btn-danger">Reject</button>
                    </div>
                </div>
            </div>
            @endforeach
        @else
            <div class="alert alert-info">There are no customer orders to show.</div>
        @endif
        @if($pharmacyOrders && !$pharmacyOrders->isEmpty())
        @foreach($pharmacyOrders as $pharmacyOrder)
        <div class="card my-4">
            <div class="card-body">
                <h5 class="card-title">Order #{{ $pharmacyOrder->OrderNum }}</h5>
                <p class="card-text">Pharmacy Name: {{ $pharmacyOrder->pharmacy->PharmaName }}</p>
                <p class="card-text">Phone Number: {{ $pharmacyOrder->pharmacy->PhoneNum }}</p>
                <p class="card-text">Pharmacist Name: {{ $pharmacyOrder->pharmacy->pharmacistName }}</p>
                <p class="card-text">Order Total: SYP {{ $pharmacyOrder->TotalPrice }}</p>
                @include('admin/modals/deliveryModal')
                <div class="d-flex justify-content-between">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#deliveryModal{{ $pharmacyOrder->ID }}">Accept</button>
                    <button type="button" class="btn btn-danger">Reject</button>
                </div>
            </div>
        </div>
        @endforeach
        @else
        <div class="alert alert-info">There are no pharmacy orders to show.</div>
        @endif

    </div>
    </div>
    <!-- End of Content Wrapper -->

            <!-- Footer -->
            @include('admin/footer')
    </div>

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