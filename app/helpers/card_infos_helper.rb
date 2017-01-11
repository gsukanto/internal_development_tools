module CardInfosHelper
  IS_CVV2 = 1
  CVV_NOT_FOUND = 'cvv not found!'
  XML_REQUEST_TEMPLATE = '<soap:Envelope 
        xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
        xmlns:fimi="http://schemas.compassplus.com/two/1.0/fimi.xsd" 
        xmlns:fimi1="http://schemas.compassplus.com/two/1.0/fimi_types.xsd">
       <soap:Header/>
       <soap:Body>
          <fimi:GetCVVRq>
             <fimi:Request Ver="%{req_version}" Product="FIMI" Clerk="%{clerk}" Password="%{password}">
                <fimi1:CardUID>%{card_uid}</fimi1:CardUID>
                <fimi1:IsCVV2>%{is_cvv2}</fimi1:IsCVV2>
                <fimi1:ExpDate>%{exp_date}</fimi1:ExpDate>
             </fimi:Request>
          </fimi:GetCVVRq>
       </soap:Body>
    </soap:Envelope>'

  def request_cvv(card_uid, exp_date)
    savon_client = Savon.client(endpoint: get_wsdl_url, namespace: '', env_namespace: :soap)
    soap_response = savon_client.call(:get_cvv_rq, xml: XML_REQUEST_TEMPLATE % make_xml_arguments(card_uid, exp_date))

    return soap_response.body
  end

  private
    def make_xml_arguments(card_uid, exp_date)
      return  { 
                :card_uid => card_uid, 
                :is_cvv2 => IS_CVV2, 
                :exp_date => filter_exp_date(exp_date), 
                :password => get_soap_password, 
                :clerk => get_clerk, 
                :req_version => get_req_version
              }
    end

    def get_wsdl_url
      return ENV['WSDL_URL']
    end

    def get_soap_password
      return ENV['SOAP_PASSWORD']
    end

    def get_clerk
      return ENV['SOAP_CLERK']
    end

    def get_req_version
      return ENV['SOAP_REQ_VERSION']
    end

    def get_cvv(body)
      if body[:get_cvv_rp] && body[:get_cvv_rp][:response]
        return body[:get_cvv_rp][:response][:str_cvv] 
      end
      return CVV_NOT_FOUND
    end

    def filter_exp_date(exp_date)
      return exp_date.strftime("%y%m")
    end
end
