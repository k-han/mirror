function [ surf_err, surf_rms ] = getReconError( surf_g, surf_e )

surf_err = surf_g-surf_e;
surf_err = surf_err.*surf_err;
surf_err = sum(surf_err,1);
surf_err = sqrt(surf_err);
surf_rms = rms(surf_err);

end

