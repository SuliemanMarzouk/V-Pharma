<?php

use App\Http\Controllers\CustomerOrderController;
use App\Http\Controllers\PharmacyController;
use App\Http\Controllers\MedicinePharmacyController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\DeliveryController;
use App\Http\Controllers\API\Auth\RegisterUserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:api')->prefix('v1')->group(function () {

//     Route::get('/user', function (Request $request) {
//         return $request->user();
//     });

//     Route::apiResource('/users', UsersController::class);

// });

Route::get('/pharmacies', [PharmacyController::class, 'getAllPharmacies']);

// Route::get('/PharmaMedicines', [MedicinePharmacyController::class, 'getPharmacyMedicines']);

Route::get('/medicines', [PharmacyController::class, 'getAllMedicines']);

Route::get('/PharmaMedicines', [PharmacyController::class, 'getPharmacyDetails']);

Route::post('/orders', [CustomerOrderController::class, 'store']);

Route::post('/registerUserApi', [RegisterUserController::class, 'registerUserApi']);

// Route::post('/createCustomerApi', [RegisterUserController::class, 'createCustomerApi']);

Route::post('/login', [UsersController::class, 'login']);

Route::post('/deliverylogin', [UsersController::class, 'deliverylogin']);

Route::put('/updateProfile/{userId}', [UsersController::class, 'updateProfile']);

Route::post('/placeOrder', [CustomerOrderController::class, 'placeOrder']);

Route::get('/customerOrders/{userId}', [CustomerOrderController::class, 'show']);

Route::get('/deliveryInfo/{userId}', [DeliveryController::class, 'deliveryInfo']);

Route::get('/deliveryOrders/{deliveryId}', [DeliveryController::class, 'deliveryOrders']);

Route::put('/updateStatus/{deliveryId}', [DeliveryController::class, 'updateStatus']);

Route::put('/deliverySubmitOrder/{orderId}', [DeliveryController::class, 'deliverySubmitOrder']);

Route::put('/deliverySubmitPharmaOrder/{orderId}', [DeliveryController::class, 'deliverySubmitPharmaOrder']);

Route::put('/updatePasswordApi/{userId}', [UsersController::class, 'updatePasswordApi']);



