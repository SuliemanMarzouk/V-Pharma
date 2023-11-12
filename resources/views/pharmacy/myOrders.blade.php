<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Pharmacy Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="{{ asset('admin/vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="{{ asset('admin/css/sb-admin-2.min.css') }}" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
        @include('pharmacy/navbar')


    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">My Orders</h1>
        </div>
        
                @if($pharmacyOrders && !$pharmacyOrders->isEmpty())
                @foreach($pharmacyOrders as $pharmacyOrder)
                    <div class="card my-4">
                        <div class="card-body">
                            <h5 class="card-title">Order #{{ $pharmacyOrder->OrderNum }}</h5>
                            <p class="card-text">Order Date: {{ $pharmacyOrder->OrderDate }}</p>
                            <p class="card-text">Order Status: 
                            @if ($pharmacyOrder->OrderStatus == 0)
                                On Hold
                            @elseif ($pharmacyOrder->OrderStatus == 1)
                                Waiting for Approval
                            @elseif ($pharmacyOrder->OrderStatus == 2)
                                Selecting Delivery
                            @elseif ($pharmacyOrder->OrderStatus == 3)
                                Delivery on the Way
                            @elseif ($pharmacyOrder->OrderStatus == 4)
                                Done
                            @elseif ($pharmacyOrder->OrderStatus == 5)
                                Canceled
                            @endif
                            </p>
                            <p class="card-text">Total Price: ${{ $pharmacyOrder->TotalPrice }}</p>
                            <!-- Display other relevant order details -->
                        </div>
                    </div>
                    @endforeach
                    @else
                    <div class="alert alert-info">There are no orders to show.</div>
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
    <script src="{{ asset('admin/vendor/jquery/jquery.min.js') }}"></script>
    <script src="{{ asset('admin/vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>

    <!-- Core plugin JavaScript-->
    <script src="{{ asset('admin/vendor/jquery-easing/jquery.easing.min.js') }}"></script>

    <!-- Custom scripts for all pages-->
    <script src="{{ asset('admin/js/sb-admin-2.min.js') }}"></script>

    <!-- Page level plugins -->
    <script src="{{ asset('admin/vendor/chart.js/Chart.min.js') }}"></script>

    <!-- Page level custom scripts -->
    <script src="{{ asset('admin/js/demo/chart-area-demo.js') }}"></script>
    <script src="{{ asset('admin/js/demo/chart-pie-demo.js') }}"></script>

</body>