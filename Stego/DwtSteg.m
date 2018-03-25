function DwtSteg(address,message)
      coverImage=imread(address);
      ascii=uint8(message);
      [LL LH HL HH]=dwt2(coverImage,'haar');
      LH=round(LH);
      HL=round(HL);
      subplot(1,2,1)
      imshow(LH)
      [r c]=size(LL);
      wc=1;
      bc=1;
      done=false;
      for i=1:r        
          if(done)
              break
          end
          for j=1:c                      
              if(bc==8)
                 bc=1;
                 wc=wc+1;
              end
              if(wc==length(message))
                  done=true;
                  break;
              end
              xb = typecast(LH(i,j), 'uint64' );
              xb=bitset(xb,1,bitget(ascii(wc),bc));
              xb%***
              LH(i,j)=typecast(xb, 'double');  
              bc=bc+1;                    
          end    
      end
      subplot(1,2,2)
      imshow(LH)
      stegoImage=idwt2(LL ,HL,LH, HH,'haar');
      figure(2)
      imshow(uint8(stegoImage));
      imwrite(uint8(stegoImage),'stegoImage.tiff');
end