function noiseIm = makeNoiseIm(dim,widthc,widthr,type)
    % 'width' is the width of the each box, in pixels
    % 'Ny/Nx' are the size of the image, in pixels
    % 'type' is a string

    r = ceil(dim(1)/widthr);
    c = ceil(dim(2)/widthc);
    
    if strcmp('random',type)
        noiseIm = [];
        for i = 1:r
            noise_c = rand(1,c);
            noise_c = interpVec(noise_c,widthc);
            noise_c = ones(widthc,1) * noise_c;
            noiseIm = [noiseIm; noise_c];
        end
        noiseIm = noiseIm(1:dim(1),1:dim(2));
    elseif strcmp('checker',type)
        noise_c = ones(1,c);
        noise_c(2:2:end) = -1;
        noise_c = interpVec(noise_c,widthc);
        noise_r = ones(1,r);
        noise_r(2:2:end) = -1;
        noise_r = interpVec(noise_r,widthr);
        noiseIm = noise_r' * noise_c;
        noiseIm = noiseIm(1:dim(1),1:dim(2));
        noiseIm = (noiseIm+1)/2;
    end

function vecout = interpVec(vec,W)
    vecout = ones(1,length(vec)*W);
    for i = 1:W
        vecout(i:W:end) = vec;
    end