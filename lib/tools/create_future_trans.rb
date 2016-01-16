def create_future_trans(their_amount, their_period)
      @_tax = @employee.taxcode #Tax code
      @_acc = @employee.accprocent #ACC percentage
      @_ks = @employee.kiwisaver #Kiwisaver % deduction
      if @_ks == nil
        @_ks = 0
      else
        @_ks = (@_ks/100).to_f
      end
      @_taxpr = (@employee.taxprocent/100).to_f #Tax procent for special codes
      
      @_kscontribution = 0 #Employer contribution to kiwisaver
      @_ksdeduction = 0 #Employee kiwisaver deduction
      their_amount_f = their_amount.to_f
      
      def get_student_loan_existing(taxcode)
        
        if taxcode.include?("SL")
          slex = 1
        else
          slex = 0
        end
        return slex
      end
      
      _slexist = get_student_loan_existing(@_tax) # Is Student loan exist?
      
      def create_common_part(stepcode)
        @trantax = FutureTransaction.new
        fiolength = @employee.fio + " salary to pay"
        @chartslim = Chart.where("users_id = ? and content = ?", current_user.id,fiolength)
        @trantax.users_id = current_user.id
        @trantax.chart_clones_id = @trantax.code/10000
        @trantax.date = DateTime.now
        @trantax.gsttype = 0
        @trantax.gst_include = 0
        @trantax.co = 2
        @trantax.gstamount = 0
        @trantax.for_moving = 0
      end
      
      def calc_tax(their_amount_f, _tc)
        # Constants
        @firstLimit = 14000
        @secondLimit = 48000
        @thirdLimit = 70000
        @firstTax = 1470
        @secondTax = 7420
        @thirdTax = 14020
        @studentLoan = 19084
        
        # byebug
        case _tc
         
          when 1

            @_flim = @firstLimit.to_f / 52
            @_slim = @secondLimit.to_f / 52
            @_tlim = @thirdLimit.to_f / 52
            @_ftax = @firstTax.to_f / 52
            @_stax = @secondTax.to_f / 52
            @_ttax = @thirdTax.to_f / 52
            @_stllim = @studentLoan.to_f / 52
          when 2
            @_flim = @firstLimit.to_f / 26
            @_slim = @secondLimit.to_f / 26
            @_tlim = @thirdLimit.to_f / 26
            @_ftax = @firstTax.to_f / 26
            @_stax = @secondTax.to_f / 26
            @_ttax = @thirdTax.to_f / 26
            @_stllim = @studentLoan.to_f / 26
          when 3
            @_flim = @firstLimit.to_f / 12
            @_slim = @secondLimit.to_f / 12
            @_tlim = @thirdLimit.to_f / 12 
            @_ftax = @firstTax.to_f / 12
            @_stax = @secondTax.to_f / 12
            @_ttax = @thirdTax.to_f / 12 
            @_stllim = @studentLoan.to_f / 12    
        end

        # Calculate tax under adjusted $14000/year
        def calc_low_tax(_amount)
          _amountret = _amount.to_f * 0.105
          return _amountret
        end

        # Calculate tax between adjusted $14000/year and $48000/year
        def calc_middle_tax(_amount)
          _amountret = _amount.to_f * 0.175
          return _amountret
        end

       # Calculate tax between adjusted $48000/year and $70000/year
        def calc_high_tax(_amount)
          _amountret = _amount.to_f * 0.3
          return _amountret
        end

        # Calculate tax above adjusted $70000/year
        def calc_top_tax(_amount)
          _amountret = _amount.to_f * 0.33
          return _amountret
        end

        # Calculate tax for special tax codes
        def calc_spec_tax(_amount)
          _amountret = _amount.to_f * @_taxpr
          return _amountret
        end

        def calc_usual_tax(_amount)
          # byebug
          case _amount 
            when 0 .. @_flim
              _amountret = _amount.to_f * 0.105
            when  @_flim .. @_slim
              @_rest = _amount.to_f - @_flim
              _amountret = @_ftax + @_rest.to_f * 0.175
            when @_slim ..@_tlim
              @_rest = _amount.to_f - @_slim
              _amountret = @_stax + @_rest.to_f * 0.3
            when  @_tlim .. 1000000000
              @_rest = _amount.to_f - @_tlim
              _amountret = @_ttax + @_rest.to_f * 0.33
          end                
          return _amountret.round(2)
        end

        ret_tax = 0
        theam = their_amount_f * 1.03
        
        case @_tax
          when 'SB','SB SL'
            if @_ks > 0
              ret_tax_big = calc_low_tax(theam) 
              ret_tax_small = calc_low_tax(their_amount_f)
              @_kscontribution = (theam - their_amount_f) - (ret_tax_big - ret_tax_small)
              return ret_tax_big.round(2)
            else
              ret_tax = calc_low_tax(their_amount_f)
              return ret_tax.round(2)
            end
          when 'S','S SL'
            if @_ks > 0
              ret_tax_big = calc_middle_tax(theam) 
              ret_tax_small = calc_middle_tax(their_amount_f)
              _kscontribution = (theam - their_amount_f) - (ret_tax_big - ret_tax_small)
              return ret_tax_big.round(2)
            else
              ret_tax = calc_middle_tax(their_amount_f)
              return ret_tax.round(2)
            end
          when 'H','SH SL'
            if @_ks > 0
              ret_tax_big = calc_high_tax(theam) 
              ret_tax_small = calc_high_tax(their_amount_f)
              @_kscontribution = (theam - their_amount_f) - (ret_tax_big - ret_tax_small)
              return ret_tax_big.round(2)
            else
              ret_tax = calc_high_tax(their_amount_f)
              return ret_tax.round(2)
            end
          when 'ST','ST SL'
            if @_ks > 0
              ret_tax_big = calc_top_tax(theam) 
              ret_tax_small = calc_top_tax(their_amount_f)
              @_kscontribution = (theam - their_amount_f) - (ret_tax_big - ret_tax_small)
              return ret_tax_big.round(2)
            else
              ret_tax = calc_top_tax(their_amount_f)
              return ret_tax.round(2)
            end
          when 'WT','STC','CAE','EDW','NSW'
            ret_tax = calc_spec_tax(their_amount_f)
            return ret_tax.round(2)
          when 'M','M SL','ME','ME SL'
            if @_ks != nil
              if @_ks > 0
                ret_tax_big = calc_usual_tax(theam) 
                ret_tax_small = calc_usual_tax(their_amount_f)
                @_kscontribution = (theam - their_amount_f) - (ret_tax_big - ret_tax_small)
                return ret_tax_big.round(2)
              else
                ret_tax = calc_usual_tax(their_amount_f)
                return ret_tax.round(2)
              end
            else
              ret_tax = calc_usual_tax(their_amount_f)
              return ret_tax.round(2)
            end  
        end #Case
      end #calc_tax

      def calc_acc(their_amount_f, _ta) #_ta is _acc
        ret_acc = their_amount_f * _ta / 100
        return ret_acc
      end

      def calc_sl(their_amount_f)
        if their_amount_f > @_stllim.to_f
          ret_sl = (their_amount_f - @_stllim.to_f) * 0.12
        else
          ret_sl = 0
        end
        return ret_sl
      end
      
      def calc_ks(their_amount_f, _tks)
        ret_ks = their_amount_f * _tks / 100 + @_kscontribution.to_f
        return ret_ks
      end

     
      @netamount0 = their_amount_f
      create_common_part(1)
      # byebug
      @trantax.amounttotal = calc_tax(their_amount_f,their_period)
      @trantax.netamount = @trantax.amounttotal
      
      @netamount0 = @netamount0 - @trantax.netamount
      @trantax.gstamount = 0
      @trantax.save
      
      create_common_part(2)
      @trantax.amounttotal = calc_acc(their_amount_f,@_acc)
      @trantax.netamount = @trantax.amounttotal
      @netamount0 = @netamount0 - @trantax.netamount
      @trantax.gstamount = 0
      @trantax.save

      if ['M SL','S SL','ME SL','SB SL'].include? @_tax
        create_common_part(3)
        @trantax.amounttotal = calc_sl(their_amount_f)
        @trantax.netamount = @trantax.amounttotal
        @netamount0 = @netamount0 - @trantax.netamount
        @trantax.gstamount = 0
        if @trantax.amounttotal > 0
          @trantax.save
        end     
      end

      if @_ks != nil
        if @_ks > 0
          create_common_part(4)
          @trantax.amounttotal = calc_ks(their_amount_f,@_ks)
          @trantax.netamount = @trantax.amounttotal
          @netamount0 = @netamount0 - @trantax.netamount
          @trantax.gstamount = 0
          if @trantax.amounttotal > 0
            @trantax.save
          end
        end
      end
      
      create_common_part(0)
      @trantax.amounttotal = @netamount0
      @trantax.netamount = @trantax.amounttotal
      @trantax.gstamount = 0
      @trantax.save
      
      create_common_part(5)
      @trantax.amounttotal = their_amount_f * 0.08
      @trantax.netamount = @trantax.amounttotal
      @trantax.gstamount = 0
      @trantax.save         
      
end