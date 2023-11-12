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
            <h1 class="h3 mb-0 text-gray-800">Order</h1>
        </div>

        @if($customerOrders  && !$customerOrders->isEmpty())
            @foreach($customerOrders as $customerOrder)
            <div class="card my-4">
                <div class="card-body">
                    <h5 class="card-title">Order #{{ $customerOrder->OrderNum }}</h5>
                    <p class="card-text">Customer Name: {{ $customerOrder->customer->FullName }}</p>
                    <p class="card-text">Phone Number: {{ $customerOrder->customer->PhoneNum }}</p>
                    <p class="card-text">Order Total: ${{ $customerOrder->TotalPrice }}</p>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Medicine Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($customerOrder->customerOrderDetails as $orderDetail)
                                <tr>
                                    <td>{{ $orderDetail->medicine->MedicineName }}</td>
                                    <td>${{ $orderDetail->medicine->pharmacies->first()->pivot->Price }}</td>
                                    <td>{{ $orderDetail->quantity }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between">
                        <form action="/accept-order/{{ $customerOrder->ID }}" method="POST" style="display: inline;">
                            @csrf
                            <button type="submit" class="btn btn-success">Accept</button>
                        </form>
                        <form action="/reject-order/{{ $customerOrder->ID }}" method="POST" style="display: inline;">
                            @csrf
                            <button type="submit" class="btn btn-danger">Reject</button>
                        </form>
                    </div>
                </div>
            </div>
            @endforeach
        @else
        <div class="alert alert-info">There are no customer orders to show.</div>
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