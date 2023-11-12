<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UsersResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request)
    {
        return [
            'id'=>(string)$this->id,
            'type'=>'Users',
            'attributes'=>[
                'name'=>$this->name,
                'e-mail'=>$this->email,
                'created'=>$this->created_at
            ]
        ];
    }
}
