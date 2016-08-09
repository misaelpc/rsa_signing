defmodule RsaSign do

  def sign_data(string) do
    key_pem_bin = File.read!("CSD01_AAA010101AAA.pem")
    [rsa_entry] = :public_key.pem_decode(key_pem_bin)
    private_key = :public_key.pem_entry_decode(rsa_entry, to_char_list("12345678a"))
    sign_with_private_key(private_key,string)
  end

  def sign_with_private_key(privKey,hash) do
    IO.inspect "Hash to be signed: "
    IO.inspect hash
    hash = hash
      |> String.upcase
      |> Base.decode16!

    hashcryp = :public_key.sign({:digest, hash}, :sha, privKey)
      |> Base.encode64
    IO.inspect "result"
    IO.inspect hashcryp
    hashcryp
  end



end
