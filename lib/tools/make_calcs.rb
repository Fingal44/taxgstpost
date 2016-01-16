   def make_calcs(tran, parampass) # tran is instance variable, for example @transaction
     tran.users_id = current_user.id
     tran.save(parampass)
     
     @chartc = Chart.where("code = ?" , tran.code)
     
     tran.gsttype = @chartc.first.gst
     tran.gst_include = tran.gsttype
     if tran.gsttype == 1
       if tran.gst_include == 1
         if tran.amounttotal != 0 && tran.amounttotal != nil
           tran.gstamount=(tran.amounttotal*3/23).round(2)
           tran.netamount=(tran.amounttotal - tran.gstamount).round(2)
         end
       else
         if tran.netamount != 0  && tran.netamount != nil
           tran.gstamount = (tran.netamount * 0.15).round(2)
           tran.amounttotal = (tran.netamount + tran.gstamount).round(2)
         else
           tran.gstamount=(tran.amounttotal*3/23).round(2)
           tran.netamount=(tran.amounttotal - tran.gstamount).round(2) 
         end

       end 
      
      else
        if tran.amounttotal != 0  && tran.amounttotal != nil
          tran.netamount=tran.amounttotal
        else
          tran.amounttotal = tran.netamount 
        end 
        tran.gstamount = 0  
     end
   end
