require 'rails_helper'

describe 'Store', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:params) {
    {
      store: {
        name: 'NT tshongkhang',
        category: 'grocery',
        phone_1: '17617564',
        phone_2: '17614456',
        email: 'namgay@gmail.com',
        address_attributes: {
          dzongkhag: 'thimphu',
          gewog: 'gewogu',
          village: 'vail',
          sector: '2',
          latitude: '11',
          longitude: '22',
          additional_info: 'some info'
        },
        contacts_attributes: [
          {
            name: 'Dorji',
            phone: '17616702',
            contact_type: 'manager'
          },
          {
            name: 'Dorji',
            phone: '17616702',
            contact_type: 'helper'
          }
        ],
        items_attributes: [
          {
            name: 'wai wai',
            price: 39,
            additional_info: 'small packet',
            photos_attributes: [
              {
                image: image_upload
              },
              {
                image: image_upload
              }
            ]
          }
        ],
        photos_attributes: [
          {
            image: image_upload
          },
          {
            image: image_upload
          }
        ]
      }
    }
  }

  let!(:params_2) {
    {
      store: {
        name: '8 eleven',
        category: 'grocery',
        phone_1: '17617564',
        phone_2: '17614456',
        email: 'namgay@gmail.com',
        address_attributes: {
          dzongkhag: 'Paro',
          gewog: 'gewogu',
          village: 'vail',
          sector: '2',
          latitude: '11',
          longitude: '22',
          additional_info: 'some info'
        },
        contacts_attributes: [
          {
            name: 'Dorji',
            phone: '17616702',
            contact_type: 'manager'
          },
          {
            name: 'Dorji',
            phone: '17616702',
            contact_type: 'helper'
          }
        ],
        items_attributes: [
          {
            name: 'wai wai',
            price: 39,
            additional_info: 'small packet',
            photos_attributes: [
              {
                image: image_upload
              },
              {
                image: image_upload
              }
            ]
          }
        ],
        photos_attributes: [
          {
            image: image_upload
          },
          {
            image: image_upload
          }
        ]
      }
    }
  }


  it 'creates a store' do
    post api_v1_stores_path, params: params, headers: header_params(token: token)
    expect(status).to eq(200)

    post api_v1_stores_path, params: params_2, headers: header_params(token: token)
    expect(status).to eq(200)

    get api_v1_store_path(Store.first), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)

    get api_v1_stores_path, params: { category: 'vegetable_store'}, headers: header_params(token: token)
    expect(status).to eq(200)

    delete api_v1_store_path(Store.first), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
  end
end
